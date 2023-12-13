//
//  APIManager.swift
//  nomura_assignment
//
//  Created by OSLT-0076 on 13/12/23.
//

import Foundation
import Combine

final class APIManager {
    
    static let url: URL = URL(string: "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/aud.json")!
    
    /// Fetches the exchange rates for currency AUD.
    ///
    /// - Returns: A publisher containing either currency list or an error
    static func fetchAUDExchangeRates() -> AnyPublisher<ExchangeRatesModel, Error> {
        return URLSession.shared.dataTaskPublisher(for: (url))
            .map(\.data)
            .mapError { APIManagerError.apiErrorWithCustomMessage(code: $0.errorCode, message: $0.localizedDescription) }
            .tryMap { data in
                do {
                    let currencyList = try JSONDecoder().decode(ExchangeRatesModel.self, from: data)
                    return currencyList
                } catch let e {
                    debugPrint("Json decoding error: \(e)")
                    throw APIManagerError.apiErrorWithCustomMessage(code: -2, message: "Json decoding error")
                }
            }
            .eraseToAnyPublisher()
    }
}
