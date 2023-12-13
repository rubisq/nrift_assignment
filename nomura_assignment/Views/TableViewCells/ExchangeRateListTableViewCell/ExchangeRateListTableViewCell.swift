//
//  ExchangeRateListTableViewCell.swift
//  nomura_assignment
//
//  Created by OSLT-0076 on 13/12/23.
//

import UIKit

class ExchangeRateListTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet private weak var currencyNameLabel: UILabel!
    @IBOutlet private weak var currencyExchangeRateLabel: UILabel!
    
    // MARK: Static vars
    static let nibName: String = "ExchangeRateListTableViewCell"
    static let reuseIdentifier: String = "ExchangeRateListTableViewCell"
    
    // MARK: Instance vars

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
