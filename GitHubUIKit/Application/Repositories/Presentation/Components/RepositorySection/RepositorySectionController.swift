//
//  RepositorySectionController.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 11.03.2022.
//

import Foundation
import IGListKit
import RxSwift
import RxCocoa

final class RepositorySectionController: ListSectionController {
  let viewModel: ViewModel<RepositorySectionModel>
  let disposeBag = DisposeBag()
  var cellViewModel: RepositoryCellModel?

  init(viewModel: ViewModel<RepositorySectionModel>) {
    self.viewModel = viewModel
    super.init()
    self.viewModel.state
      .drive(rx.state)
      .disposed(by: disposeBag)
  }

  override func numberOfItems() -> Int {
    return 1
  }

  override func sizeForItem(at index: Int) -> CGSize {
    return CGSize(width: collectionContext.containerSize.width, height: 55)
  }

  override func cellForItem(at index: Int) -> UICollectionViewCell {
    let cell = collectionContext.dequeueReusableCell(
      of: RepositoryCell.self,
      for: self,
      at: index
    ) as! RepositoryCell

    if let cellViewModel = cellViewModel {
      cell.configure(cellViewModel)
    }
    cell.layoutMargins = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 8)
    return cell
  }

  override func didUpdate(to object: Any) {
//    guard let cellViewModel = object as? RepositoryCellModel else { return }
//    self.viewModel.dispatch(.update(cellViewModel))
    guard let repository = (object as? ListDiffableBox<Repository>)?.value else { return }
    self.viewModel.dispatch(.update(repository))
  }
}

extension Reactive where Base: RepositorySectionController {
  var state: Binder<RepositorySectionModel.State> {
    return Binder(self.base) { view, state in
      let repository = state.repository
      view.cellViewModel = .init(
        id: repository.id,
        name: repository.name,
        description: repository.description,
        starsCount: repository.starsCount,
        forksCount: repository.forksCount
      )

      view.collectionContext.performBatch(
        animated: true,
        updates: { _ in
          guard let cell = view.collectionContext.cellForItem(at: 0, sectionController: view) as? RepositoryCell else {
            return
          }
          state.starsCountState.success.flatMap(cell.updateStarsCount(_:))
          state.forksCountState.success.flatMap(cell.updateForksCount(_:))
        },
        completion: nil
      )


    }
  }
}

