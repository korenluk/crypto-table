//
//  RootCoordinator.swift
//  crypto-table
//
//  Created by Lukas Korinek on 02.09.2021.
//

import UIKit

class RootCoordinator: Coordinating {
    private weak var window: UIWindow?

    init(window: UIWindow) {
        self.window = window
    }

    func begin() -> UIViewController {
        let vc = ViewController()
        set(rootController: vc)
        return vc
    }
}

private extension RootCoordinator {
    func set(rootController: UIViewController) {
        window?.rootViewController = rootController
    }

}
