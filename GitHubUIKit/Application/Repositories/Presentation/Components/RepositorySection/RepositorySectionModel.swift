//
//  RepositorySectionModel.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 11.03.2022.
//

import Foundation
import RxSwift

public final class RepositorySectionModel: ViewModelable {
  public var state: Observable<State> {
    return stateSubject.asObservable()
  }
  private let stateSubject: BehaviorSubject<State>

  typealias UpdateStarsCountAction = RxAction<Void, Int>
  lazy var updateStarsCountAction = UpdateStarsCountAction { [unowned self] in
    return dependency.getRepositoryStarsCountUseCase
      .execute(input: .init(repository: dependency.repository))
      .map(\.starsCount)
  }

  typealias UpdateForksCountAction = RxAction<Void, Int>
  lazy var updateForksCountAction = UpdateForksCountAction { [unowned self] in
    return dependency.getRepositoryForksCountUseCase
      .execute(input: .init(repository: dependency.repository))
      .map(\.forksCount)
  }

  public let dependency: Dependency
  let disposeBag = DisposeBag()

  public init(
    dependency: Dependency
  ) {
    self.dependency = dependency
    self.stateSubject = .init(
      value: .init(
        repository: dependency.repository,
        starsCountState: .success(dependency.repository.starsCount),
        forksCountState: .success(dependency.repository.forksCount)
      )
    )

    updateStarsCountAction
      .elements
      .subscribe(onNext: { count in
        guard var state = try? self.stateSubject.value() else { return }
        state.starsCountState = .success(count)
        self.stateSubject.onNext(state)
      })
      .disposed(by: disposeBag)

    updateForksCountAction
      .elements
      .subscribe(onNext: { count in
        guard var state = try? self.stateSubject.value() else { return }
        state.forksCountState = .success(count)
        self.stateSubject.onNext(state)
      })
      .disposed(by: disposeBag)
  }

  public func dispatch(_ action: Action) {
    switch action {
    case let .update(repository):
      handleUpdateAction(repository: repository)
    }
  }

  private func handleUpdateAction(repository: Repository) {
    guard var state = try? self.stateSubject.value() else { return }
    state.repository = repository
    self.stateSubject.onNext(state)
    updateStarsCountAction.execute()
    updateForksCountAction.execute()
  }
}

public extension RepositorySectionModel {
  struct State {
    fileprivate(set) var repository: Repository
    fileprivate(set) var starsCountState: BaseState<Int, Never>
    fileprivate(set) var forksCountState: BaseState<Int, Never>
  }
}

public extension RepositorySectionModel {
  enum Action {
    case update(Repository)
  }
}

public extension RepositorySectionModel {
  struct Dependency {
    let repository: Repository
    let getRepositoryStarsCountUseCase: GetRepositoryStarsCountUseCase
    let getRepositoryForksCountUseCase: GetRepositoryForksCountUseCase
  }
}
