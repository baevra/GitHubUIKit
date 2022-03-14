//
//  GetRepositoryForksCountQuery.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 14.03.2022.
//

import Foundation
import RxSwift

public protocol GetRepositoryForksCountQuery {
  typealias Input = GetRepositoryForksCountQueryInput
  typealias Output = GetRepositoryForksCountQueryOutput

  func execute(input: Input) -> Observable<Output>
}

public struct GetRepositoryForksCountQueryInput {
  public let repository: Repository
}

public struct GetRepositoryForksCountQueryOutput {
  public let forksCount: Int
}

