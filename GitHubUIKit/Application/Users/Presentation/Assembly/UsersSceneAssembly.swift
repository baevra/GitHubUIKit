//
//  UsersSceneAssembly.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 10.03.2022.
//

import UIKit

public protocol UsersSceneAssembly {
  func assemble() -> UIViewController
}

public struct UsersSceneAssemblyDefault: UsersSceneAssembly {
  public func assemble() -> UIViewController {
    let getUsersQuery = GetUsersQueryDefault()
    let getUsersUseCase = GetUsersUseCaseDefault(
      dependency: .init(
        getUsersQuery: getUsersQuery
      )
    )
    let viewModel = UsersSceneViewModel(
      dependency: .init(
        getUsersUseCase: getUsersUseCase
      )
    )
    let viewController = UsersSceneViewController(viewModel: .init(viewModel: viewModel))
    return viewController
  }
}
