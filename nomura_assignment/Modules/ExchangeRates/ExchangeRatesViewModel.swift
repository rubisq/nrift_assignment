//
//  ExchangeRatesViewModel.swift
//  nomura_assignment
//
//  Created by OSLT-0076 on 13/12/23.
//

import Foundation
import Combine

final class ExchangeRatesViewModel: ObservableObject {
    
    @Published private(set) var exchangeRatesLinkedList: LinkedList<ExchangeRateItem> = LinkedList()
    @Published private(set) var isRefreshing: Bool = false
    
    private var cancellableSet = Set<AnyCancellable>()
    private var originalExchangeRatesLinkedList: LinkedList<ExchangeRateItem> = LinkedList()
    
    // MARK: Networking
    
    /// Fetch from the exchange rates API
    func fetchExchangeRates(asRefresh: Bool = false) {
        if asRefresh { isRefreshing = true }
        APIManager.fetchAUDExchangeRates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                guard let self = self else { return }
                if asRefresh { self.isRefreshing = false }
                switch result {
                case .finished:
                    debugPrint("FetchExchangeRates Complete")
                case .failure(let e):
                    debugPrint(e)
                }
            } receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.parse(value)
            }
            .store(in: &cancellableSet)
    }
    
    // MARK: Utils
    
    /// Searches the linked list and replace `exchangeRatesLinkedList` with
    /// the filtered values so the UI shows them
    ///
    /// - Parameter keyword: The keyword to search with. Provide blank (`""`)
    /// string to reset the search
    func search(by keyword: String) {
        guard !keyword.isEmpty else {
            exchangeRatesLinkedList = originalExchangeRatesLinkedList
            return 
        }
        exchangeRatesLinkedList = originalExchangeRatesLinkedList.filter { $0.name.localizedCaseInsensitiveContains(keyword) }
    }
    
    /// Parse the api response, insert then into the linked list, and sort it.
    ///
    /// - Parameter response: The response received from exchange rates API
    private func parse(_ response: ExchangeRatesModel) {
        let list: LinkedList<ExchangeRateItem> = LinkedList()
        response.aud.forEach { list.insert(node: ExchangeRateItem(name: $0, rate: $1)) }
        list.printList()
        list.bubbleSort()
        list.printList()
        exchangeRatesLinkedList = list
        originalExchangeRatesLinkedList = list
    }
}
