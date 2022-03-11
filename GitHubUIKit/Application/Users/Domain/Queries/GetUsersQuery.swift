//
//  GetUsersQuery.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 10.03.2022.
//

import Foundation
import RxSwift

public protocol GetUsersQuery {
  func execute() -> Observable<[User]>
}
