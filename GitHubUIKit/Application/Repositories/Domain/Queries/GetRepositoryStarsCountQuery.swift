//
//  GetRepositoryStarsCountQuery.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 14.03.2022.
//

import Foundation
import RxSwift

public protocol GetRepositoryStarsCountQuery {
  typealias Input = GetRepositoryStarsCountQueryInput
  typealias Output = GetRepositoryStarsCountQueryOutput

  func execute(input: Input) -> Observable<Output>
}

public struct GetRepositoryStarsCountQueryInput {
  public let repository: Repository
}

public struct GetRepositoryStarsCountQueryOutput {
  public let starsCount: Int
}
