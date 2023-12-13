//
//  LinkedList.swift
//  nomura_assignment
//
//  Created by OSLT-0076 on 13/12/23.
//

import Foundation

class Node<N> {
    var value: N
    var next: Node?
    
    init(value: N) {
        self.value = value
    }
}

class LinkedList<N> {
    var head: Node<N>?
    var tail: Node<N>?
    
    func insert(node: N) {
        let newNode = Node(value: node)
        if let tailNode = tail {
            tailNode.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
    }
    
    func printList() {
        var current = head
        while current != nil {
            print("\(current!.value) -> ", terminator: "")
            current = current?.next
        }
        print("nil")
    }
}
