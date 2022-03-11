//
//  RepositoriesCoordinator.swift
//  AltaiCoffeeUIKit
//
//  Created by Roman Baev on 05.03.2022.
//

import UIKit
import CoordinatorKit

public final class RepositoriesCoordinator: FlowCoordinator {
  public let router: FlowRouter
  public let storage: CoordinatorStorage

  public var onFinish: ((Result<Void, FlowCoordinatorError>) -> Void)?

  public init(router: FlowRouter) {
    self.router = router
    self.storage = CoordinatorStorage()
  }

  public func start() {
    startRepositories()
  }

  func startRepositories() {
    let assembly = RepositoriesSceneAssemblyDefault()
    let viewController = assembly.assemble()
    viewController.navigationItem.title = "Repositories"
    router.push(viewController, animated: true)
  }
}
