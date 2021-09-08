//
//  RootCoordinator.swift
//  crypto-table
//
//  Created by Lukas Korinek on 02.09.2021.
//

import UIKit

class RootCoordinator: Coordinating {
    private weak var window: UIWindow?
    private let resolver: DependencyResolving

    init(window: UIWindow, resolver: DependencyResolving) {
        self.window = window
        self.resolver = resolver
    }

    func begin() -> UIViewController {
        let viewController = createCryptoTableController()
        set(rootController: viewController)
        return viewController
    }
}

private extension RootCoordinator {
    func set(rootController: UIViewController) {
        window?.rootViewController = rootController
    }

    func createCryptoTableController() -> UIViewController {
        let navController = createNavController()

        let coordinator = CryptoTableCoordinator(navController: navController, resolver: resolver)
        let viewController = coordinator.begin()
        navController.viewControllers = [viewController]
        return navController
    }

    func createNavController() -> UINavigationController {
        let navController = UINavigationController()
        navController.navigationBar.tintColor = .cyan
        navController.navigationBar.barTintColor = .black
        navController.navigationBar.barStyle = .black
        return navController
    }

}
