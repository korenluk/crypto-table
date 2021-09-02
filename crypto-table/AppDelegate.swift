//
//  AppDelegate.swift
//  crypto-table
//
//  Created by Lukas Korinek on 02.09.2021.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    var coordinator: RootCoordinator?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        coordinator = RootCoordinator(window: window)
        let rootViewController = coordinator?.begin()

        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        self.window = window

        return true
    }
}
