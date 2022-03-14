//
//  GetRepositoriesQuery.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 05.03.2022.
//

import Foundation
import RxSwift

public protocol GetRepositoriesQuery {
  func execute() -> Observable<[Repository]>
}
