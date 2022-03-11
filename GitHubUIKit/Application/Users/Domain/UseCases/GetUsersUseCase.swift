//
//  GetUsersUseCase.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 10.03.2022.
//

import Foundation
import RxSwift

public protocol GetUsersUseCase {
  func execute() -> Observable<[User]>
}

public class GetUsersUseCaseDefault: GetUsersUseCase {
  public let dependency: Dependency

  public init(dependency: Dependency) {
    self.dependency = dependency
  }

  public func execute() -> Observable<[User]> {
    return dependency.getUsersQuery.execute()
  }
}

public extension GetUsersUseCaseDefault {
  struct Dependency {
    let getUsersQuery: GetUsersQuery
  }
}
