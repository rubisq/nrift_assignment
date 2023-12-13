//
//  ExchangeRateDataTests.swift
//  nomura_assignmentTests
//
//  Created by OSLT-0076 on 13/12/23.
//

import XCTest
@testable import nomura_assignment

final class ExchangeRateDataTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEmptyLinkedList() {
        let list = LinkedList<ExchangeRateItem>()
        XCTAssertNil(list.head)
        XCTAssertNil(list.tail)
        XCTAssertEqual(list.length, 0)
    }
    
    // Check sorting in descending order
    func testLinkedListSorting() {
        let list = LinkedList<ExchangeRateItem>()
        list.bubbleSort()
        XCTAssertEqual(list.length, 0)
        list.insert(node: ExchangeRateItem(name: "AB", rate: 20.8))
        list.insert(node: ExchangeRateItem(name: "CD", rate: 22.8))
        list.insert(node: ExchangeRateItem(name: "EF", rate: 20.0))
        list.insert(node: ExchangeRateItem(name: "AX", rate: 20.8))
        XCTAssertEqual(list.length, 4)
        list.bubbleSort()
        XCTAssertEqual(list.head?.value.name, "CD")
        XCTAssertEqual(list.head?.next?.value.name, "AX")
        XCTAssertEqual(list.head?.next?.next?.value.name, "AB")
        XCTAssertEqual(list.head?.next?.next?.next?.value.name, "EF")
    }

}
