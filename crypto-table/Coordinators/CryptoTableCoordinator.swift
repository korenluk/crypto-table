//
//  CryptoTableCoordinator.swift
//  crypto-table
//
//  Created by Lukas Korinek on 07.09.2021.
//

import UIKit

protocol CryptoTableCoordinating {
    func select(crypto: String)
}

class CryptoTableCoordinator: CryptoTableCoordinating {
    private let resolver: DependencyResolving
    private weak var navController: UINavigationController?

    init(navController: UINavigationController, resolver: DependencyResolving) {
        self.navController = navController
        self.resolver = resolver
    }

    deinit {
        print("TABLE DEINIT")
    }

    func begin() -> UIViewController {
        var viewController = resolver.resolveCryptoTableScene()
        viewController.coordinator = self
        return viewController
    }

    func select(crypto: String) {
        let coordinator = CryptoDetailCoordinator(crypto: crypto, navController: navController!, resolver: resolver)
        let viewController = coordinator.begin()
        navController?.pushViewController(viewController, animated: true)
    }
}
