//
//  RepositoriesSceneView.swift
//  GitHubUIKit
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
      .map(ListDiffableBox.init(value:))
  }

  func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
    // TODO: - Move to parent assembly?
    guard let repository = (object as? ListDiffableBox<Repository>)?.value else {
      fatalError("Unsupported object \(object)")
    }
    let section = RepositorySectionAssemblyDefault()
    return section.assemble(repository: repository)
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
  var state: Binder<RepositoriesSceneModel.State> {
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
