//
//  CryptoRouter.swift
//  crypto-table
//
//  Created by Lukas Korinek on 02.09.2021.
//

import Foundation

struct CryptoRouter {
    static let apiKey = "?access_key=0acda1ee535118c1f2a7f8656ee98e94"

    static let baseUrl = "http://api.coinlayer.com/api"

    static let live: URLRequest = {
        var request = URLRequest(url: URL(string: "\(baseUrl)/live\(apiKey)")!)
        return request
    }()

    static let list: URLRequest = {
        var request = URLRequest(url: URL(string: "\(baseUrl)/list\(apiKey)")!)
        return request
    }()
}
