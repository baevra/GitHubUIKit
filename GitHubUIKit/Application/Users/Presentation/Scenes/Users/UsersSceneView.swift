//
//  UsersSceneView.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 10.03.2022.
//

import UIKit
import FlexLayout
import RxSwift
import RxCocoa

final class UsersSceneView: FlexView {
  let tableView: BaseTableView = {
    let tableView = BaseTableView()
    tableView.register(UserCell.self)
    tableView.refreshControl = UIRefreshControl()
    return tableView
  }()

  let usersRelay = PublishRelay<[User]?>()
  let disposeBag = DisposeBag()

  init() {
    super.init(frame: .zero)
    usersRelay
      .asDriver(onErrorJustReturn: nil)
      .compactMap { $0 }
      .drive(tableView.rx.items) { tableView, index, model in
        let cell = tableView.dequeueReusableCell(
          for: UserCell.self
        )
        cell.configure(model)
        return cell
      }
      .disposed(by: disposeBag)
  }

  override func setupSubviews() {
    super.setupSubviews()
    contentView.flex
      .define {
        $0.addItem(tableView)
          .grow(1)
      }
  }
}

extension Reactive where Base: UsersSceneView {
  var refresh: ControlEvent<Void> {
    base.tableView.refreshControl!.rx.controlEvent(.valueChanged)
  }
}

extension Reactive where Base: UsersSceneView {
  var state: Binder<UsersSceneViewModel.State> {
    return Binder(self.base) { view, state in
      if let users = state.users.success {
        view.usersRelay.accept(users)
      }

      if state.users.isLoading {
        view.tableView.refreshControl?.beginRefreshing()
      } else {
        view.tableView.refreshControl?.endRefreshing()
      }
    }
  }
}

