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
  let viewModel: ViewModel<RepositorySectionViewModel>
  let disposeBag = DisposeBag()
  var cellViewModel: RepositoryCellViewModel?

  init(viewModel: ViewModel<RepositorySectionViewModel>) {
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
    guard let cellViewModel = object as? RepositoryCellViewModel else { return }
    self.viewModel.dispatch(.update(cellViewModel))
  }
}

extension Reactive where Base: RepositorySectionController {
  var state: Binder<RepositorySectionViewModel.State> {
    return Binder(self.base) { view, state in
      if let cellViewModel = state.cellViewModel.success {
        view.cellViewModel = cellViewModel
      }
      if let starsCount = state.starsCount.success {
        if let cell = view.collectionContext.cellForItem(at: 0, sectionController: view) as? RepositoryCell {
          cell.updateStarsCount(starsCount)
        }
      }
      if let forksCount = state.forksCount.success {
        if let cell = view.collectionContext.cellForItem(at: 0, sectionController: view) as? RepositoryCell {
          cell.updateForksCount(forksCount)
        }
      }
    }
  }
}

