//
//  CryptoTableViewModel.swift
//  crypto-table
//
//  Created by Lukas Korinek on 07.09.2021.
//

import UIKit

class CryptoTableViewModel: CryptoTableViewModeling {
    weak var delegate: CryptoTableViewModelDelegate?

    private var isFetching: Bool = false

    private let cryptoService: CryptoServiceType
    private var cryptoRows = [CryptoRow]()
    private var target = ""

    init(cryptoService: CryptoServiceType) {
        self.cryptoService = cryptoService
    }

    func downloadCrypto() {
        fetchCrypto()
    }

    func numberOfCrypto() -> Int {
        cryptoRows.count
    }

    func crypto(at index: Int) -> CryptoRow {
        cryptoRows[index]
    }

    func getTarget() -> String {
        return target
    }
}

private extension CryptoTableViewModel {
    func fetchCrypto() {
        guard !isFetching else {
            return
        }

        isFetching = true

        cryptoService.fetchCryptoLive { [weak self] result in
            guard let self = self else {
                return
            }

            self.isFetching = false

            switch result {
            case let .success(cryptoLive):
                self.target = cryptoLive.target
                for (key, value) in cryptoLive.rates {
                    self.cryptoRows.append(CryptoRow(name: key, price: value))
                }
                self.cryptoRows.sort()
                self.delegate?.didDownloadCrypto()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
}
