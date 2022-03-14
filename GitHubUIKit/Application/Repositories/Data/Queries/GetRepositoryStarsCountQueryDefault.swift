//
//  GetRepositoryStarsCountQueryDefault.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 14.03.2022.
//

import Foundation
import RxSwift

public final class GetRepositoryStarsCountQueryDefault: GetRepositoryStarsCountQuery {
  public func execute(input: Input) -> Observable<Output> {
    return Observable<Int>
      .interval(RxTimeInterval.seconds(2), scheduler: MainScheduler.instance)
      .map { _ in }
      .map { [0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 4] }
      .compactMap { $0.randomElement() }
      .scan(input.repository.starsCount, accumulator: +)
      .distinctUntilChanged()
      .map(Output.init(starsCount:))
  }
}
