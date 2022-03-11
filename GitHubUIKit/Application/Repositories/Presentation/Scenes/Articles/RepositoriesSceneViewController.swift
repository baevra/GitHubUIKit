//
//  RepositoriesSceneViewController.swift
//  AltaiCoffeeUIKit
//
//  Created by Roman Baev on 05.03.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class RepositoriesSceneViewController: BaseViewController<RepositoriesSceneView> {
  let viewModel: ViewModel<RepositoriesSceneViewModel>

  init(viewModel: ViewModel<RepositoriesSceneViewModel>) {
    self.viewModel = viewModel
    super.init()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.dispatch(.appear)
  }

  override func setupView(view: RepositoriesSceneView) {
    super.setupView(view: view)
    view.viewController = self
  }

  override func bindViewModel(view: RepositoriesSceneView) {
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
