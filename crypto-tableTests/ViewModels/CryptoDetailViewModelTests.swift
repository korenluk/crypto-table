//
//  CryptoDetailViewModelTests.swift
//  crypto-tableTests
//
//  Created by Lukas Korinek on 08.09.2021.
//

import XCTest
@testable import crypto_table

class CryptoDetailViewModelTests: XCTestCase {

    var viewModel: CryptoDetailViewModel!

    override func setUp() {
        super.setUp()
        viewModel = CryptoDetailViewModel(crypto: "", cryptoService: CryptoServiceMock())
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func test_viewModel_downloadCrypto() {
        viewModel.crypto = "BTC"
        viewModel.downloadCrypto()
        guard let cryptoDetail = viewModel.cryptoDetail else {
            XCTFail("Crypto Detail is nil.")
            return
        }
        XCTAssert(cryptoDetail.name == "Bitcoin", "Name should be Bitcoin.")
    }

    func test_viewModel_downloadCrypto_fail() {
        viewModel.crypto = "KKK"
        viewModel.downloadCrypto()
        XCTAssert(viewModel.cryptoDetail == nil, "Crypto Detail should be nil")
    }
}
