//
//  ExchangeRatesModel.swift
//  nomura_assignment
//
//  Created by OSLT-0076 on 13/12/23.
//

import Foundation

typealias ExchangeRateItemDict = [String: Double]

struct ExchangeRatesModel: Codable {
    let date: String
    let aud: ExchangeRateItemDict
}

struct ExchangeRateItem: Comparable {
    static func < (lhs: ExchangeRateItem, rhs: ExchangeRateItem) -> Bool {
        // Compares by rate, and when rate is equal compares by name.
        lhs.rate < rhs.rate || (lhs.rate == rhs.rate && lhs.name < rhs.name)
    }
    
    static func > (lhs: ExchangeRateItem, rhs: ExchangeRateItem) -> Bool {
        // Compares by rate, and when rate is equal compares by name.
        lhs.rate > rhs.rate || (lhs.rate == rhs.rate && lhs.name > rhs.name)
    }
    
    let name: String
    let rate: Double
}
