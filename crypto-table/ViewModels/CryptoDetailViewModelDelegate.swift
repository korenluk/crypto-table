//
//  CryptoDetailViewModelDelegate.swift
//  crypto-table
//
//  Created by Lukas Korinek on 07.09.2021.
//

protocol CryptoDetailViewModelDelegate: AnyObject {
    func didDownloadCrypto()
    func didFail(with error: CryptoError)
}

protocol CryptoDetailViewModeling: AnyObject {
    var delegate: CryptoDetailViewModelDelegate? { get set }
    var crypto: String { get }
    func downloadCrypto()
}
