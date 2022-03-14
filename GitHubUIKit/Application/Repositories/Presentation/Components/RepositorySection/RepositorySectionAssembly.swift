//
//  RepositorySectionAssembly.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 14.03.2022.
//

import UIKit
import IGListKit

public protocol RepositorySectionAssembly {
  func assemble(repository: Repository) -> ListSectionController
}

public struct RepositorySectionAssemblyDefault: RepositorySectionAssembly {
  public func assemble(repository: Repository) -> ListSectionController {
    let getRepositoryStarsCountQuery = GetRepositoryStarsCountQueryDefault()
    let getRepositoryStarsCountUseCase = GetRepositoryStarsCountUseCaseDefault(
      dependency: .init(
        getRepositoryStarsCountQuery: getRepositoryStarsCountQuery
      )
    )
    let getRepositoryForksCountQuery = GetRepositoryForksCountQueryDefault()
    let getRepositoryForksCountUseCase = GetRepositoryForksCountUseCaseDefault(
      dependency: .init(
        getRepositoryForksCountQuery: getRepositoryForksCountQuery
      )
    )

    let viewModel = RepositorySectionModel(
      dependency: .init(
        repository: repository,
        getRepositoryStarsCountUseCase: getRepositoryStarsCountUseCase,
        getRepositoryForksCountUseCase: getRepositoryForksCountUseCase
      )
    )
    let controller = RepositorySectionController(viewModel: .init(viewModel: viewModel))
    return controller
  }
}
