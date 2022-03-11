//
//  UsersSceneViewModel.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 10.03.2022.
//

import Foundation
import RxSwift

public final class UsersSceneViewModel: ViewModelable {
  public var state: Observable<State> {
    return stateSubject.asObservable()
  }
  private let stateSubject: BehaviorSubject<State>

  typealias LoadUsersAction = RxAction<Void, [User]>
  lazy var loadUsersAction = LoadUsersAction { [unowned self] in
    return self.dependency.getUsersUseCase
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

    loadUsersAction
      .executing
      .filter { $0 }
      .map { _ in }
      .subscribe(onNext: { [unowned self] in
        guard var state = try? self.stateSubject.value() else { return }
        state.users = .loading
        self.stateSubject.onNext(state)
      })
      .disposed(by: disposeBag)

    loadUsersAction
      .elements
      .subscribe(onNext: { [unowned self] users in
        guard var state = try? self.stateSubject.value() else { return }
        state.users = .success(users)
        self.stateSubject.onNext(state)
      })
      .disposed(by: disposeBag)

    loadUsersAction
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
    loadUsersAction.execute()
  }
}

public extension UsersSceneViewModel {
  struct State {
    fileprivate(set) var users: BaseState<[User], Never>

    public static var initial: Self {
      return .init(users: .idle)
    }
  }
}

public extension UsersSceneViewModel {
  enum Action {
    case appear
    case refresh
  }
}

public extension UsersSceneViewModel {
  struct Dependency {
    let getUsersUseCase: GetUsersUseCase
  }
}
