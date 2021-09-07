//
//  CryptoAPIManager.swift
//  crypto-table
//
//  Created by Lukas Korinek on 06.09.2021.
//

import Foundation

final class CryptoAPIManager {
    let jsonDecoder = JSONDecoder()
}

extension CryptoAPIManager: APIManaging {
    func request<T: Decodable>(request: URLRequest, completion: @escaping (Swift.Result<T, Error>) -> Void) {
        let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in

            if let httpResponse = response as? HTTPURLResponse,
               !(200..<300).contains(httpResponse.statusCode) {
                completion(.failure(CryptoError(success: false,
                                                error: CryptoDetailError(code: httpResponse.statusCode,
                                                                         type: "Bad Response",
                                                                         info: httpResponse.description))))
                return
            }

            guard let data = data else {
                completion(.failure(CryptoError(success: false,
                                                error: CryptoDetailError(code: 0,
                                                                         type: "Data",
                                                                         info: "Data corupted"))))
                return
            }

            do {
                let object = try self.jsonDecoder.decode(CryptoResponse.self, from: data)
                if object.success == true {
                    let cryptoLive = try self.jsonDecoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(cryptoLive))
                    }
                } else {
                    let cryptoError = try self.jsonDecoder.decode(CryptoError.self, from: data)
                    completion(.failure(cryptoError))
                }
            } catch {
                completion(.failure(error))
            }
        }
        urlSession.resume()
    }
}
