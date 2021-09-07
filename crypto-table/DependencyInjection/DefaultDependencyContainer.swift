//
//  DefaultDependencyContainer.swift
//  crypto-table
//
//  Created by Lukas Korinek on 07.09.2021.
//

class DefaultDependencyContainer: DependencyResolving {
    // MARK: - Managers
    func resolveAPIManager() -> APIManaging {
        return CryptoAPIManager()
    }
}
