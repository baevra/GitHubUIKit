//
//  GetRepositoryStarsCountUseCase.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 14.03.2022.
//

import Foundation
import RxSwift

public protocol GetRepositoryStarsCountUseCase {
  typealias Input = GetRepositoryStarsCountUseCaseInput
  typealias Output = GetRepositoryStarsCountUseCaseOutput

  func execute(input: Input) -> Observable<Output>
}

public struct GetRepositoryStarsCountUseCaseInput {
  public let repository: Repository
}

public struct GetRepositoryStarsCountUseCaseOutput {
  public let starsCount: Int
}

public class GetRepositoryStarsCountUseCaseDefault: GetRepositoryStarsCountUseCase {
  public let dependency: Dependency

  public init(dependency: Dependency) {
    self.dependency = dependency
  }

  public func execute(input: Input) -> Observable<Output> {
    return dependency.getRepositoryStarsCountQuery
      .execute(input: .init(repository: input.repository))
      .map { .init(starsCount: $0.starsCount) }
  }
}

public extension GetRepositoryStarsCountUseCaseDefault {
  struct Dependency {
    let getRepositoryStarsCountQuery: GetRepositoryStarsCountQuery
  }
}
