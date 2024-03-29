//
//  CryptoAPIManager.swift
//  crypto-table
//
//  Created by Lukas Korinek on 06.09.2021.
//

import Foundation

final class CryptoAPIManager {
    private let jsonDecoder = JSONDecoder()

    private lazy var session: URLSession = {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: sessionConfiguration)
    }()

    private func decode<T: Decodable>(data: Data, completion: @escaping (Swift.Result<T, CryptoError>) -> Void) {
        do {
            let cryptoResponse = try self.jsonDecoder.decode(CryptoResponse.self, from: data)
            if cryptoResponse.success == true {
                let object = try self.jsonDecoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(object))
                }
            } else {
                let cryptoError = try self.jsonDecoder.decode(CryptoError.self, from: data)
                DispatchQueue.main.async {
                    completion(.failure(cryptoError))
                }
            }
        } catch {
            DispatchQueue.main.async {
                completion(.failure(CryptoError(success: false,
                                                error: CryptoDetailError(code: 0,
                                                                         type: "Decoding error",
                                                                         info: error.localizedDescription))))
            }
        }
    }
}

extension CryptoAPIManager: APIManaging {
    func request<T: Decodable>(request: URLRequest, completion: @escaping (Swift.Result<T, CryptoError>) -> Void) {

        if let cachedData = URLCache.shared.cachedResponse(for: request) {
            print("Cached data in bytes:", cachedData.data)

            decode(data: cachedData.data, completion: completion)

        } else {
            session.dataTask(with: request) { data, response, error in

                if let httpResponse = response as? HTTPURLResponse,
                   !(200..<300).contains(httpResponse.statusCode) {
                    DispatchQueue.main.async {
                        completion(.failure(CryptoError(success: false,
                                                        error: CryptoDetailError(code: httpResponse.statusCode,
                                                                                 type: "Bad Response",
                                                                                 info: httpResponse.description))))
                    }
                    return
                }

                guard let data = data, let response = response else {
                    DispatchQueue.main.async {
                        completion(.failure(CryptoError(success: false,
                                                        error: CryptoDetailError(code: 0,
                                                                                 type: "Network Error",
                                                                                 info: "Network Error"))))
                    }
                    return
                }

                let cachedData = CachedURLResponse(response: response, data: data)
                URLCache.shared.storeCachedResponse(cachedData, for: request)

                self.decode(data: data, completion: completion)

            }.resume()

        }
    }
}
