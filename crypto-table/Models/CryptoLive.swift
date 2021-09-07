//
//  CryptoList.swift
//  crypto-table
//
//  Created by Lukas Korinek on 06.09.2021.
//

struct CryptoLive: Codable {
    let success: Bool
    let terms: String
    let privacy: String
    let timestamp: Int
    let target: String
    let rates: [String: Double]
}

struct CryptoRow: Codable, Comparable {
    let name: String
    let price: Double
    static func < (lhs: CryptoRow, rhs: CryptoRow) -> Bool {
        // order from highest price
        lhs.price > rhs.price
    }
}
