//
//  CryptoTableViewModelDelegate.swift
//  crypto-table
//
//  Created by Lukas Korinek on 07.09.2021.
//

import Foundation

protocol CryptoTableViewModelDelegate: AnyObject {
    func didUpdateCrypto()
    func didFail(with error: Error)
}

protocol CryptoTableViewModeling: AnyObject {
    var delegate: CryptoTableViewModelDelegate? { get set }

    func updateCrypto()
    func numberOfCrypto() -> Int
    func crypto(at index: Int) -> CryptoRow
}
