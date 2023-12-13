//
//  swift
//  nomura_assignment
//
//  Created by OSLT-0076 on 13/12/23.
//

import Foundation

class Node<N: Comparable>: Equatable {
    static func == (lhs: Node<N>, rhs: Node<N>) -> Bool {
        lhs.value == rhs.value
    }
    
    var value: N
    var next: Node<N>?
    
    init(value: N) {
        self.value = value
    }
}

class LinkedList<N: Comparable> {
    /// Head of the linked list, i.e. the first element
    var head: Node<N>?
    /// Tail of the linked list, i.e. the last element
    var tail: Node<N>?
    
    /// Length of the linked list chain
    var length: Int {
        var count = 0
        var current = head
        while current != nil {
            count += 1
            current = current?.next
        }
        return count
    }
    
    /// Inserts a node at the `next` of the current `tail` of the linked list
    ///
    /// - Parameter node: The node to insert
    ///
    /// - Complexity: O(*1*)
    func insert(node: N) {
        let newNode = Node(value: node)
        if let tailNode = tail {
            tailNode.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
    }
    
    /// Clears the linked list
    func clear() {
        head = nil
        tail = nil
    }
    
    /// Finds the node at the given position. Uses O(n) time complexity.
    ///
    /// - Parameter position: position in terms of linked chain length.
    ///
    /// - Complexity: O(*n*)
    func getItem(at position: Int) -> Node<N>? {
        guard position != 0 else { return head }
        var nodeToReturn = head
        (0 ..< position).forEach { _ in
            nodeToReturn = nodeToReturn?.next
        }
        return nodeToReturn
    }
    
    /// Swaps the current node with the next node. Required in bubble sort method.
    ///
    /// - Parameter current: The node that needs to be swapped with the next one.
    func swapWithNextNode(current: Node<N>?) {
        guard let nextValue = current?.next?.value, let temp = current?.value else { return }
        current?.value = nextValue
        current?.next?.value = temp
    }
    
    /// Swaps the linked list using bubble sort.
    ///
    /// - Complexity: O(*n^2*)
    func bubbleSort() {
        guard head != nil && head?.next != nil else { return }
        var i = head
        while i != tail {
            var j = head
            while j != tail {
                guard let v1 = j?.value, let v2 = j?.next?.value else { continue }
                if (v1 < v2) {
                    swapWithNextNode(current: j)
                }
                j = j?.next
            }
            i = i?.next
        }
    }
    
    /// Filter function to create new linked list out of the filtered elements
    /// of the existing one. It uses an Swift's inbuilt filter like signature.
    ///
    /// - Parameter predicate: A closure where the current value is passed, so that
    /// it can be tested whether it's eligible as a filtered value and returns the
    /// boolean return.
    ///
    /// - Returns: The filtered linked list.
    ///
    /// - Complexity: O(*n*)
    func filter(_ predicate: (N) -> Bool) -> LinkedList<N> {
        let newLinkedList = LinkedList<N>()
        var current = head
        while current != nil {
            guard let value = current?.value else { continue }
            if predicate(value) {
                newLinkedList.insert(node: value)
            }
            current = current?.next
        }
        return newLinkedList
    }
    
    /// Prints the list by iterating through its linked nodes.
    func printList() {
        var current = head
        while current != nil {
            debugPrint("\(current!.value) -> ", terminator: "")
            current = current?.next
        }
        debugPrint("nil")
    }
}
