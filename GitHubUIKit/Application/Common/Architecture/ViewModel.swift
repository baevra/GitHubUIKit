//
//  ViewModel.swift
//  AltaiCoffeeUIKit
//
//  Created by Roman Baev on 05.03.2022.
//

import RxSwift
import RxCocoa

public final class ViewModel<VM: ViewModelable> {
  public lazy var state: Driver<VM.State> = {
    viewModel.state
      .map(Optional.init)
      .asDriver(onErrorJustReturn: nil)
      .compactMap { $0 }
  }()

  private(set) var viewModel: VM
  let disposeBag = DisposeBag()

  public init(viewModel: VM) {
    self.viewModel = viewModel
  }

  func dispatch(_ action: VM.Action) {
    viewModel.dispatch(action)
  }
}
