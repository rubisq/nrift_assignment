//
//  ExchangeRatesViewController.swift
//  nomura_assignment
//
//  Created by OSLT-0076 on 13/12/23.
//

import UIKit
import Combine

class ExchangeRatesViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Instance variables
    private lazy var viewModel = ExchangeRatesViewModel()
    private var cancellableSet = Set<AnyCancellable>()

    // MARK: Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        configureViewModel()
        viewModel.fetchExchangeRates()
    }
    
    // MARK: UI Setup
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: ExchangeRateListTableViewCell.nibName, bundle: .main), forCellReuseIdentifier: ExchangeRateListTableViewCell.reuseIdentifier)
        tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        
        title = "AUD Currency Exchange Rates"
    }
    
    // MARK: ViewModel configuration
    private func configureViewModel() {
        viewModel.$exchangeRatesLinkedList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                tableView.reloadData()
            }
            .store(in: &cancellableSet)
    }
    
}

extension ExchangeRatesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.exchangeRatesLinkedList.length
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeRateListTableViewCell.reuseIdentifier, for: indexPath) as! ExchangeRateListTableViewCell
        let item = viewModel.exchangeRatesLinkedList.getItem(at: indexPath.row)
        cell.exchangeRate = item?.value
        return cell
    }
}
