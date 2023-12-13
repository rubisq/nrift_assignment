//
//  ExchangeRateListModel.swift
//  nomura_assignment
//
//  Created by OSLT-0076 on 13/12/23.
//

import Foundation

typealias ExchangeRateItemDict = [String: Double]

struct ExchangeRateListModel: Codable {
    let date: String
    let aud: ExchangeRateItemDict
}
