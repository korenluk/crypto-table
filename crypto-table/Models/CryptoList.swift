//
//  CryptoList.swift
//  crypto-table
//
//  Created by Lukas Korinek on 07.09.2021.
//

struct CryptoList: Codable {
    let success: Bool
    let crypto: [String: CryptoDetail]
}

struct CryptoDetail: Codable {
    let symbol: String
    let name: String
    let nameFull: String
    let maxSupply: String
    let iconUrl: String

    private enum CodingKeys: String, CodingKey {
        case symbol = "symbol"
        case name = "name"
        case nameFull = "name_full"
        case maxSupply = "max_supply"
        case iconUrl = "icon_url"
    }

    init(symbol: String, name: String, nameFull: String, maxSupply: String, iconUrl: String) {
        self.symbol = symbol
        self.name = name
        self.nameFull = nameFull
        self.maxSupply = maxSupply
        self.iconUrl = iconUrl
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        symbol = try String(container.decode(String.self, forKey: .symbol))
        name = try String(container.decode(String.self, forKey: .name))
        nameFull = try String(container.decode(String.self, forKey: .nameFull))
        iconUrl = try String(container.decode(String.self, forKey: .iconUrl))

        do {
            maxSupply = try String(container.decode(Double.self, forKey: .maxSupply))
        } catch DecodingError.typeMismatch {
            maxSupply = try container.decode(String.self, forKey: .maxSupply)
        }
    }
}
