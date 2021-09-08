//
//  CryptoServiceType.swift
//  crypto-table
//
//  Created by Lukas Korinek on 07.09.2021.
//

import Foundation

protocol CryptoServiceType {
    func fetchCryptoLive(completion: @escaping (Result<CryptoLive, CryptoError>) -> Void)
    func fetchCryptoList(completion: @escaping (Result<CryptoList, CryptoError>) -> Void)
}
