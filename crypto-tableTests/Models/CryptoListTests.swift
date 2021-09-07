//
//  CryptoListTests.swift
//  crypto-tableTests
//
//  Created by Lukas Korinek on 07.09.2021.
//

import XCTest
@testable import crypto_table

class CryptoListTests: XCTestCase {
    var jsonDecoder: JSONDecoder!

    let json = """
        {
            "success": true,
            "crypto": {
                "USDT": {
                            "symbol": "USDT",
                            "name": "Tether",
                            "name_full": "Tether (USDT)",
                            "max_supply": "N/A",
                            "icon_url": "https://assets.coinlayer.com/icons/USDT.png"
                        },
                "AION": {
                            "symbol": "AION",
                            "name": "Aion",
                            "name_full": "Aion (AION)",
                            "max_supply": 465934586.66,
                            "icon_url": "https://assets.coinlayer.com/icons/AION.png"
                        }
            }
        }
        """.data(using: .utf8)

    override func setUp() {
        super.setUp()
        jsonDecoder = JSONDecoder()
    }

    override func tearDown() {
        jsonDecoder = nil
        super.tearDown()
    }

    func test_cryptoList_decode() {
        do {
            let cryptoList = try jsonDecoder.decode(CryptoList.self, from: json!)
            XCTAssert(cryptoList.success == true &&
                      cryptoList.crypto["USDT"]?.maxSupply == "N/A" &&
                      cryptoList.crypto["AION"]?.maxSupply == "465934586.66")
        } catch {
            XCTFail("Decode error")
        }
    }
}
