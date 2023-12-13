//
//  ExchangeRatesViewController.swift
//  nomura_assignment
//
//  Created by OSLT-0076 on 13/12/23.
//

import UIKit

class ExchangeRatesViewController: UIViewController {
    
    // MARK: - Outlets -
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Life cycle methods -
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - UI Setup -
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: ExchangeRateListTableViewCell.nibName, bundle: .main), forCellReuseIdentifier: ExchangeRateListTableViewCell.reuseIdentifier)
        tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        
        title = "AUD Currency Exchange Rates"
    }
    
}

extension ExchangeRatesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeRateListTableViewCell.reuseIdentifier, for: indexPath) as! ExchangeRateListTableViewCell
        
        return cell
    }
}