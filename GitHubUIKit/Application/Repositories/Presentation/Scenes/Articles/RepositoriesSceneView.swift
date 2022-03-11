//
//  RepositoriesSceneView.swift
//  AltaiCoffeeUIKit
//
//  Created by Roman Baev on 05.03.2022.
//

import UIKit
import FlexLayout
import RxSwift
import RxCocoa
import IGListKit

final class RepositoriesSceneView: FlexView {
  unowned var viewController: UIViewController!

  lazy var listAdapter: ListAdapter = {
    let updater = ListAdapterUpdater()
    let adapter = ListAdapter(updater: updater, viewController: viewController)
    adapter.collectionView = collectionView
    adapter.dataSource = self
    return adapter
  }()

  lazy var collectionView: UICollectionView = {
    let layout = VerticalCollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(RepositoryCell.self)
    collectionView.refreshControl = UIRefreshControl()
    return collectionView
  }()

  fileprivate(set) var repositories: [Repository] = [] {
    didSet {
      listAdapter.performUpdates(animated: true)
    }
  }

  override func setupSubviews() {
    super.setupSubviews()
    contentView.flex
      .define {
        $0.addItem(collectionView)
          .grow(1)
      }
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    collectionView.frame = bounds
  }
}

extension RepositoriesSceneView: ListAdapterDataSource {
  func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
    return repositories
      .map {
        RepositoryCellViewModel(
          id: $0.id,
          name: $0.name,
          description: $0.description,
          starsCount: $0.starsCount,
          forksCount: $0.forksCount
        )
      }
  }

  func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
    let viewModel = RepositorySectionViewModel(dependency: .init())
    return RepositorySectionController(viewModel: .init(viewModel: viewModel))
  }

  func emptyView(for listAdapter: ListAdapter) -> UIView? {
    return nil
  }
}

extension Reactive where Base: RepositoriesSceneView {
  var refresh: ControlEvent<Void> {
    base.collectionView.refreshControl!.rx.controlEvent(.valueChanged)
  }
}

extension Reactive where Base: RepositoriesSceneView {
  var state: Binder<RepositoriesSceneViewModel.State> {
    return Binder(self.base) { view, state in
      if let repositories = state.repositories.success {
        view.repositories = repositories
      }

      if state.repositories.isLoading {
        view.collectionView.refreshControl?.beginRefreshing()
      } else {
        view.collectionView.refreshControl?.endRefreshing()
      }
    }
  }
}
