//
//  CryptoService.swift
//  crypto-table
//
//  Created by Lukas Korinek on 06.09.2021.
//

import Foundation

class CryptoService: CryptoServiceType {
    let apiManager: CryptoAPIManager

    init(apiManager: CryptoAPIManager) {
        self.apiManager = apiManager
    }

    func fetchCryptoLive(completion: @escaping (Result<CryptoLive, Error>) -> Void) {
        apiManager.request(request: CryptoRouter.live, completion: completion)
    }

    func fetchCryptoList(completion: @escaping (Result<CryptoList, Error>) -> Void) {
        apiManager.request(request: CryptoRouter.list, completion: completion)
    }
}
