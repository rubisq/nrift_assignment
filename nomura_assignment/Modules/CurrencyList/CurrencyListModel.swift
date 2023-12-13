//
//  CurrencyListModel.swift
//  nomura_assignment
//
//  Created by OSLT-0076 on 13/12/23.
//

import Foundation

typealias CurrencyItemDict = [String: Double]

struct CurrencyListModel: Codable {
    let date: String
    let aud: CurrencyItemDict
}
