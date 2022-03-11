//
//  RepositorySectionViewModel.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 11.03.2022.
//

import Foundation
import RxSwift

public final class RepositorySectionViewModel: ViewModelable {
  public var state: Observable<State> {
    return stateSubject.asObservable()
  }
  private let stateSubject: BehaviorSubject<State>

  typealias UpdateStarsCountAction = RxAction<Int, Int>
  lazy var updateStarsCountAction = UpdateStarsCountAction { count in
    return Observable<Int>
      .interval(RxTimeInterval.seconds(2), scheduler: MainScheduler.instance)
      .map { _ in }
      .map { [0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 4].randomElement()! }
      .scan(count, accumulator: +)
      .distinctUntilChanged()
  }

  typealias UpdateForksCountAction = RxAction<Int, Int>
  lazy var updateForksCountAction = UpdateForksCountAction { count in
    return Observable<Int>
      .interval(RxTimeInterval.seconds(4), scheduler: MainScheduler.instance)
      .map { _ in }
      .map { [0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 4].randomElement()! }
      .scan(count, accumulator: +)
      .distinctUntilChanged()
  }

  public let dependency: Dependency
  let disposeBag = DisposeBag()

  public init(
    initialState: State = .initial,
    dependency: Dependency
  ) {
    self.dependency = dependency
    self.stateSubject = .init(value: initialState)

    updateStarsCountAction
      .elements
      .subscribe(onNext: { count in
        guard var state = try? self.stateSubject.value() else { return }
        state.starsCount = .success(count)
        self.stateSubject.onNext(state)
      })
      .disposed(by: disposeBag)

    updateForksCountAction
      .elements
      .subscribe(onNext: { count in
        guard var state = try? self.stateSubject.value() else { return }
        state.forksCount = .success(count)
        self.stateSubject.onNext(state)
      })
      .disposed(by: disposeBag)
  }

  public func dispatch(_ action: Action) {
    switch action {
    case let .update(viewModel):
      handleUpdateAction(viewModel: viewModel)
    }
  }

  private func handleUpdateAction(viewModel: RepositoryCellViewModel) {
    guard var state = try? self.stateSubject.value() else { return }
    state.cellViewModel = .success(viewModel)
    self.stateSubject.onNext(state)
    updateStarsCountAction.execute(viewModel.starsCount)
    updateForksCountAction.execute(viewModel.forksCount)
  }
}

public extension RepositorySectionViewModel {
  struct State {
    fileprivate(set) var cellViewModel: BaseState<RepositoryCellViewModel, Never>
    fileprivate(set) var starsCount: BaseState<Int, Never>
    fileprivate(set) var forksCount: BaseState<Int, Never>

    public static var initial: Self {
      return .init(cellViewModel: .idle, starsCount: .idle, forksCount: .idle)
    }
  }
}

public extension RepositorySectionViewModel {
  enum Action {
    case update(RepositoryCellViewModel)
  }
}

public extension RepositorySectionViewModel {
  struct Dependency {
  }
}
