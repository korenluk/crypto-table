//
//  CryptoServiceMock.swift
//  crypto-tableTests
//
//  Created by Lukas Korinek on 07.09.2021.
//

import Foundation
@testable import crypto_table

class CryptoServiceMock: CryptoServiceType {
    let cryptoLive = CryptoLive(success: true,
                                terms: "terms",
                                privacy: "privacy",
                                timestamp: 1631020026,
                                target: "USD",
                                rates: ["BTC": 51022,
                                        "ETH": 3965,
                                        "RPX": 0.123])

    let cryptoList = CryptoList(success: true,
                                crypto: ["BTC": CryptoDetail(symbol: "BTC",
                                                             name: "Bitcoin",
                                                             nameFull: "Bitcoin (BTC)",
                                                             maxSupply: "21000000",
                                                             iconUrl: "https://assets.coinlayer.com/icons/BTC.png"),
                                         "ETH": CryptoDetail(symbol: "ETH",
                                                             name: "Ethereum",
                                                             nameFull: "Ethereum (ETH)",
                                                             maxSupply: "0",
                                                             iconUrl: "https://assets.coinlayer.com/icons/ETH.png")])

    func fetchCryptoLive(completion: @escaping (Result<CryptoLive, CryptoError>) -> Void) {
        completion(.success( cryptoLive))
    }

    func fetchCryptoList(completion: @escaping (Result<CryptoList, CryptoError>) -> Void) {
        completion(.success(cryptoList))
    }
}
