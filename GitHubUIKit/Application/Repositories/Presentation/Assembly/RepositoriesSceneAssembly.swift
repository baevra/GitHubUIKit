//
//  RepositoriesSceneAssembly.swift
//  AltaiCoffeeUIKit
//
//  Created by Roman Baev on 05.03.2022.
//

import UIKit

public protocol RepositoriesSceneAssembly {
  func assemble() -> UIViewController
}

public struct RepositoriesSceneAssemblyDefault: RepositoriesSceneAssembly {
  public func assemble() -> UIViewController {
    let getRepositoriesQuery = GetRepositoriesQueryDefault()
    let getRepositoriesUseCase = GetRepositoriesUseCaseDefault(
      dependency: .init(
        getRepositoriesQuery: getRepositoriesQuery
      )
    )
    let viewModel = RepositoriesSceneViewModel(
      dependency: .init(
        getRepositoriesUseCase: getRepositoriesUseCase
      )
    )
    let viewController = RepositoriesSceneViewController(viewModel: .init(viewModel: viewModel))
    return viewController
  }
}
