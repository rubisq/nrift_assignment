//
//  CurrencyListTableViewCell.swift
//  nomura_assignment
//
//  Created by OSLT-0076 on 13/12/23.
//

import UIKit

class CurrencyListTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet private weak var currencyNameLabel: UILabel!
    @IBOutlet private weak var currencyExchangeRateLabel: UILabel!
    
    // MARK: Static vars
    static let nibName: String = "CurrencyListTableViewCell"
    static let reuseIdentifier: String = "CurrencyListTableViewCell"
    
    // MARK: Instance vars

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
