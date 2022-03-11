//
//  UsersSceneViewController.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 10.03.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class UsersSceneViewController: BaseViewController<UsersSceneView> {
  let viewModel: ViewModel<UsersSceneViewModel>

  init(viewModel: ViewModel<UsersSceneViewModel>) {
    self.viewModel = viewModel
    super.init()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.dispatch(.appear)
  }

  override func bindViewModel(view: UsersSceneView) {
    super.bindViewModel(view: view)
    viewModel.state
      .drive(view.rx.state)
      .disposed(by: disposeBag)

    view.rx.refresh
      .bind(onNext: { [viewModel] in
        viewModel.dispatch(.refresh)
      })
      .disposed(by: disposeBag)
  }
}
