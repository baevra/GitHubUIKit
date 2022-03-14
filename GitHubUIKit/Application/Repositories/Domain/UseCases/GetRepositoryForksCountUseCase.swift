//
//  GetRepositoryForksCountUseCase.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 14.03.2022.
//

import Foundation
import RxSwift

public protocol GetRepositoryForksCountUseCase {
  typealias Input = GetRepositoryForksCountUseCaseInput
  typealias Output = GetRepositoryForksCountUseCaseOutput

  func execute(input: Input) -> Observable<Output>
}

public struct GetRepositoryForksCountUseCaseInput {
  public let repository: Repository
}

public struct GetRepositoryForksCountUseCaseOutput {
  public let forksCount: Int
}

public class GetRepositoryForksCountUseCaseDefault: GetRepositoryForksCountUseCase {
  public let dependency: Dependency

  public init(dependency: Dependency) {
    self.dependency = dependency
  }

  public func execute(input: Input) -> Observable<Output> {
    return dependency.getRepositoryForksCountQuery
      .execute(input: .init(repository: input.repository))
      .map { .init(forksCount: $0.forksCount) }
  }
}

public extension GetRepositoryForksCountUseCaseDefault {
  struct Dependency {
    let getRepositoryForksCountQuery: GetRepositoryForksCountQuery
  }
}
