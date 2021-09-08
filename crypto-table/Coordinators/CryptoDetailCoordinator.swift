//
//  CryptoDetailCoordinator.swift
//  crypto-table
//
//  Created by Lukas Korinek on 07.09.2021.
//

import UIKit

protocol CryptoDetailCoordinating: Coordinating {

}

class CryptoDetailCoordinator: CryptoDetailCoordinating {
    private let resolver: DependencyResolving
    private let crypto: String
    private weak var navController: UINavigationController?

    init(crypto: String, navController: UINavigationController, resolver: DependencyResolving) {
        self.crypto = crypto
        self.resolver = resolver
        self.navController = navController
    }

    deinit {
        print("Crypto DETAIL DEINIT")
    }

    func begin() -> UIViewController {
        var viewController = resolver.resolveCryptoDetailScene(crypto: crypto)
        viewController.coordinator = self
        return viewController
    }
}
