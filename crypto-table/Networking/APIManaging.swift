//
//  APIManaging.swift
//  crypto-table
//
//  Created by Lukas Korinek on 07.09.2021.
//
import Foundation

protocol APIManaging {
    func request<T: Decodable>(request: URLRequest, completion: @escaping (Swift.Result<T, Error>) -> Void)
}
