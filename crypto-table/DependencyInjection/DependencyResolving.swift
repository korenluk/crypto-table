//
//  DependencyResolving.swift
//  crypto-table
//
//  Created by Lukas Korinek on 07.09.2021.
//

import UIKit

protocol DependencyResolving {
    func resolveAPIManager() -> APIManaging
}

extension DependencyResolving {

    func resolveCryptoTableScene() -> CryptoTableViewControlling & UIViewController {
        let viewController = CryptoTableViewController()
        viewController.viewModel = resolveCryptoTableViewModel()
        return viewController
    }

    func resolveCryptoTableViewModel() -> CryptoTableViewModel {
        return CryptoTableViewModel(cryptoService: resolveCryptoService())
    }

    func resolveCryptoDetailScene(crypto: String) -> CryptoDetailViewControlling & UIViewController {
        let viewController = CryptoDetailViewController()
        viewController.viewModel = resolveCryptoDetailViewModel(crypto: crypto)
        return viewController
    }

    func resolveCryptoDetailViewModel(crypto: String) -> CryptoDetailViewModel {
        return CryptoDetailViewModel(crypto: crypto, cryptoService: resolveCryptoService())
    }

    func resolveCryptoService() -> CryptoServiceType {
        return CryptoService(apiManager: resolveAPIManager())
    }
}
