//
//  CryptoTableViewModelDelegate.swift
//  crypto-table
//
//  Created by Lukas Korinek on 07.09.2021.
//

import Foundation

protocol CryptoTableViewModelDelegate: AnyObject {
    func didDownloadCrypto()
    func didFail(with error: CryptoError)
}

protocol CryptoTableViewModeling: AnyObject {
    var delegate: CryptoTableViewModelDelegate? { get set }

    func downloadCrypto()
    func numberOfCrypto() -> Int
    func crypto(at index: Int) -> CryptoRow
    func getTarget() -> String
}
