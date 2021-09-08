//
//  CryptoDetailViewModel.swift
//  crypto-table
//
//  Created by Lukas Korinek on 07.09.2021.
//
import Foundation

class CryptoDetailViewModel: CryptoDetailViewModeling {
    weak var delegate: CryptoDetailViewModelDelegate?

    private var isFetching: Bool = false

    internal var crypto: String

    var crytoDetail: CryptoDetail?

    private let cryptoService: CryptoServiceType

    init(crypto: String, cryptoService: CryptoServiceType) {
        self.crypto = crypto
        self.cryptoService = cryptoService
    }

    func downloadCrypto() {
        fetchCrypto()
    }
}

private extension CryptoDetailViewModel {
    func fetchCrypto() {
        guard !isFetching else {
            return
        }

        isFetching = true
        cryptoService.fetchCryptoList { [weak self] result in
            guard let self = self else {
                return
            }
            self.isFetching = false

            switch result {
            case let .success(cryptoList):
                for (key, value) in cryptoList.crypto where self.crypto == key {
                    self.crytoDetail = value
                }
                self.delegate?.didDownloadCrypto()
            case let .failure(error):
                self.delegate?.didFail(with: error)
            }
        }
    }
}
