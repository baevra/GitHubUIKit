//
//  GetRepositoryForksCountQueryDefault.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 14.03.2022.
//

import Foundation
import RxSwift

public final class GetRepositoryForksCountQueryDefault: GetRepositoryForksCountQuery {
  public func execute(input: Input) -> Observable<Output> {
    return Observable<Int>
      .interval(RxTimeInterval.seconds(4), scheduler: MainScheduler.instance)
      .map { _ in }
      .map { [0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 4] }
      .compactMap { $0.randomElement() }
      .scan(input.repository.forksCount, accumulator: +)
      .distinctUntilChanged()
      .map(Output.init(forksCount:))
  }
}
