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

    init(cryptoService: CryptoServiceType) {
        self.cryptoService = cryptoService
    }

    func updateCrypto() {
        fetchCrypto()
    }

    func numberOfCrypto() -> Int {
        cryptoRows.count
    }

    func crypto(at index: Int) -> CryptoRow {
        cryptoRows[index]
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
                for (key, value) in cryptoLive.rates {
                    self.cryptoRows.append(CryptoRow(name: key, price: value))
                }
                self.cryptoRows.sort()
                self.delegate?.didUpdateCrypto()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
}
