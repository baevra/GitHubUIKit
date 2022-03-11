//
//  AppDelegate.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 09.03.2022.
//

import UIKit
import CoordinatorKit
import Action

typealias RxAction = Action

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  var applicationCoordinator: ApplicationCoordinator?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.backgroundColor = .white

    let applicationRouter = RootRouter(window: window)
    let applicationCoordinator = ApplicationCoordinator(router: applicationRouter)
    applicationCoordinator.start()

    self.window = window
    self.applicationCoordinator = applicationCoordinator
    return true
  }
}

