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
    
    private var cancellableSet = Set<AnyCancellable>()
    
    // MARK: Networking
    func fetchExchangeRates() {
        APIManager.fetchAUDExchangeRates()
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .finished:
                    debugPrint("FetchExchangeRates Complete")
                case .failure(let e):
                    debugPrint(e)
                }
            } receiveValue: { [weak self] value in
                guard let self = self else { return }
                parse(value)
            }
            .store(in: &cancellableSet)
    }
    
    // MARK: Utils
    private func parse(_ response: ExchangeRatesModel) {
        let list: LinkedList<ExchangeRateItem> = LinkedList()
        response.aud.forEach { list.insert(node: ExchangeRateItem(name: $0, rate: $1)) }
        list.printList()
        list.bubbleSort()
        list.printList()
        exchangeRatesLinkedList = list
    }
}
