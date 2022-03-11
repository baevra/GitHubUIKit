//
//  ApplicationCoordinator.swift
//  AltaiCoffeeUIKit
//
//  Created by Roman Baev on 05.03.2022.
//

import UIKit
import CoordinatorKit

public final class ApplicationCoordinator: RootCoordinator {
  public let router: RootRouter
  public let storage: CoordinatorStorage

  public init(router: RootRouter) {
    self.router = router
    self.storage = CoordinatorStorage()
  }

  public func start() {
    startRepositories()
  }

  func startRepositories() {
    let navigationController = UINavigationController()
    navigationController.isNavigationBarHidden = true
    let router = FlowRouter(navigationController: navigationController)
    let coordinator = TabBarCoordinator(router: router)
    self.router.setRoot(navigationController)
    start(coordinator) { _ in }
  }
}
