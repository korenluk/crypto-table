//
//  CryptoError.swift
//  crypto-table
//
//  Created by Lukas Korinek on 07.09.2021.
//

struct CryptoError: Codable, Error {
    let success: Bool
    let error: CryptoDetailError
}

struct CryptoDetailError: Codable {
    let code: Int
    let type: String
    let info: String
}
