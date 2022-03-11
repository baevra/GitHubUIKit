//
//  TabBarCoordinator.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 11.03.2022.
//

import UIKit
import CoordinatorKit

final class TabBarCoordinator: FlowCoordinator {
  let router: FlowRouter
  let storage: CoordinatorStorage

  var onFinish: ((Result<Void, FlowCoordinatorError>) -> Void)?

  init(router: FlowRouter) {
    self.router = router
    self.storage = CoordinatorStorage()
  }

  func start() {
    startTabBar()
  }

  func startTabBar() {
    let usersNavigationController = UINavigationController()
    usersNavigationController.tabBarItem.title = "Users"
    let usersRounter = FlowRouter(navigationController: usersNavigationController)
    let usersCoordinator = UsersCoordinator(router: usersRounter)
    start(usersCoordinator) { _ in }

    let repositoriesNavigationController = UINavigationController()
    repositoriesNavigationController.tabBarItem.title = "Repositories"
    let repositoriesRouter = FlowRouter(navigationController: repositoriesNavigationController)
    let repositoriesCoordinator = RepositoriesCoordinator(router: repositoriesRouter)
    start(repositoriesCoordinator) { _ in }

    let tabBarController = UITabBarController()
    tabBarController.viewControllers = [usersNavigationController, repositoriesNavigationController]

    router.push(tabBarController, animated: true)
  }
}
