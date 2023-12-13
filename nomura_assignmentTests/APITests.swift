//
//  APITests.swift
//  nomura_assignmentTests
//
//  Created by OSLT-0076 on 13/12/23.
//

import XCTest
import Combine
@testable import nomura_assignment

final class APITests: XCTestCase {
    
    var cancellableSet: Set<AnyCancellable>!

    override func setUp() {
        cancellableSet = Set()
    }

    override func tearDown() {
        cancellableSet = nil
    }
    
    func testAPIData() {
        let apiExpectation: XCTestExpectation = XCTestExpectation(description: "API call succeed within time limit.")
        var result: Result<ExchangeRatesModel, Error>?
        APIManager.fetchAUDExchangeRates()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let e):
                    result = .failure(e)
                    apiExpectation.fulfill()
                }
            } receiveValue: { data in
                result = .success(data)
                apiExpectation.fulfill()
            }
            .store(in: &cancellableSet)
        
        wait(for: [apiExpectation], timeout: 5.0)
        
        switch result {
        case .success(let data):
            XCTAssertNotNil(data, "Must not be nil")
            XCTAssertNotNil(data.aud, "Must not be nil")
            XCTAssertNotEqual(data.aud.count, 0, "Must contain some elements.")
        case .failure(let error):
            XCTFail("Unexpected error: \(error)")
        case .none:
            XCTFail("Result is nil")
        }
    }
    
}
