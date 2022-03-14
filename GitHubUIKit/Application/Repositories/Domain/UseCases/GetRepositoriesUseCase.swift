//
//  GetRepositoriesUseCase.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 05.03.2022.
//

import Foundation
import RxSwift

public protocol GetRepositoriesUseCase {
  func execute() -> Observable<[Repository]>
}

public class GetRepositoriesUseCaseDefault: GetRepositoriesUseCase {
  public let dependency: Dependency

  public init(dependency: Dependency) {
    self.dependency = dependency
  }

  public func execute() -> Observable<[Repository]> {
    return dependency.getRepositoriesQuery.execute()
  }
}

public extension GetRepositoriesUseCaseDefault {
  struct Dependency {
    let getRepositoriesQuery: GetRepositoriesQuery
  }
}
