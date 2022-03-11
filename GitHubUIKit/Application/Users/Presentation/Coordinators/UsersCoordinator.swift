//
//  UsersCoordinator.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 10.03.2022.
//

import UIKit
import CoordinatorKit

public final class UsersCoordinator: FlowCoordinator {
  public let router: FlowRouter
  public let storage: CoordinatorStorage

  public var onFinish: ((Result<Void, FlowCoordinatorError>) -> Void)?

  public init(router: FlowRouter) {
    self.router = router
    self.storage = CoordinatorStorage()
  }

  public func start() {
    startUsers()
  }

  func startUsers() {
    let assembly = UsersSceneAssemblyDefault()
    let viewController = assembly.assemble()
    viewController.navigationItem.title = "Users"
    router.push(viewController, animated: true)
  }
}
