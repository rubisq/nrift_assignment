//
//  ExchangeRatesViewController.swift
//  nomura_assignment
//
//  Created by OSLT-0076 on 13/12/23.
//

import UIKit
import Combine

class ExchangeRatesViewController: UITableViewController {
    
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
    
    deinit {
        refreshControl?.removeTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
    }
    
    // MARK: UI Setup
    private func setupUI() {
        tableView.register(UINib(nibName: ExchangeRateListTableViewCell.nibName, bundle: .main), forCellReuseIdentifier: ExchangeRateListTableViewCell.reuseIdentifier)
        tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        // Adding a search bar using UISearchController class
        navigationItem.searchController = UISearchController()
        navigationItem.searchController?.searchBar.delegate = self
        // Adding a refresh control
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        
        title = "AUD Currency Exchange Rates"
    }
    
    // MARK: ViewModel configuration
    private func configureViewModel() {
        viewModel.$exchangeRatesLinkedList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.tableView.reloadData()
            }
            .store(in: &cancellableSet)
        viewModel.$isRefreshing
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                if value {
                    self.refreshControl?.beginRefreshing()
                } else {
                    self.refreshControl?.endRefreshing()
                }
            }
            .store(in: &cancellableSet)
    }
    
    // MARK: Actions
    @objc private func handleRefresh(_ sender: UIRefreshControl) {
        viewModel.fetchExchangeRates(asRefresh: true)
    }
    
}

extension ExchangeRatesViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.exchangeRatesLinkedList.length
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeRateListTableViewCell.reuseIdentifier, for: indexPath) as! ExchangeRateListTableViewCell
        let item = viewModel.exchangeRatesLinkedList.getItem(at: indexPath.row)
        cell.exchangeRate = item?.value
        return cell
    }
    
}

extension ExchangeRatesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        viewModel.search(by: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("Cleared")
        viewModel.search(by: "")
    }
}
