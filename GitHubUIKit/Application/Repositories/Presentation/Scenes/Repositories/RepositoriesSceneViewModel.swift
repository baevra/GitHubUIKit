//
//  RepositoriesSceneViewModel.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 05.03.2022.
//

import Foundation
import RxSwift

public final class RepositoriesSceneViewModel: ViewModelable {
  public var state: Observable<State> {
    return stateSubject.asObservable()
  }
  private let stateSubject: BehaviorSubject<State>

  typealias LoadRepositoriesAction = RxAction<Void, [Repository]>
  lazy var loadRepositoriesAction = LoadRepositoriesAction { [unowned self] in
    return self.dependency.getRepositoriesUseCase
      .execute()
  }

  public let dependency: Dependency
  let disposeBag = DisposeBag()

  public init(
    initialState: State = .initial,
    dependency: Dependency
  ) {
    self.dependency = dependency
    self.stateSubject = .init(value: initialState)

    loadRepositoriesAction
      .executing
      .filter { $0 }
      .map { _ in }
      .subscribe(onNext: { [unowned self] in
        guard var state = try? self.stateSubject.value() else { return }
        state.repositories = .loading
        self.stateSubject.onNext(state)
      })
      .disposed(by: disposeBag)

    loadRepositoriesAction
      .elements
      .subscribe(onNext: { [unowned self] repositories in
        guard var state = try? self.stateSubject.value() else { return }
        state.repositories = .success(repositories)
        self.stateSubject.onNext(state)
      })
      .disposed(by: disposeBag)

    loadRepositoriesAction
      .errors
      .subscribe(onNext: { error in
        print(error)
      })
      .disposed(by: disposeBag)
  }

  public func dispatch(_ action: Action) {
    switch action {
    case .appear:
      handleAppearAction()
    case .refresh:
      handleAppearAction()
    }
  }

  private func handleAppearAction() {
    loadRepositoriesAction.execute()
  }
}

public extension RepositoriesSceneViewModel {
  struct State {
    fileprivate(set) var repositories: BaseState<[Repository], Never>

    public static var initial: Self {
      return .init(repositories: .idle)
    }
  }
}

public extension RepositoriesSceneViewModel {
  enum Action {
    case appear
    case refresh
  }
}

public extension RepositoriesSceneViewModel {
  struct Dependency {
    let getRepositoriesUseCase: GetRepositoriesUseCase
  }
}
