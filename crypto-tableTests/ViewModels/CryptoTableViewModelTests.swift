//
//  CryptoTableViewModelTests.swift
//  crypto-tableTests
//
//  Created by Lukas Korinek on 08.09.2021.
//

import XCTest
@testable import crypto_table

class CryptoTableViewModelTests: XCTestCase {

    var viewModel: CryptoTableViewModel!

    override func setUp() {
        super.setUp()
        viewModel = CryptoTableViewModel(cryptoService: CryptoServiceMock())
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func test_viewModel_downloadCrypto() {
        viewModel.downloadCrypto()
        XCTAssert(viewModel.numberOfCrypto() != 0, "Count of crypto should not be 0")
        XCTAssert(viewModel.crypto(at: 1).name == "ETH", "Name of crypto on index 1 should be ETH")
    }
}
