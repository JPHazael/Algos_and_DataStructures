//: Playground - noun: a place where people can play

import UIKit

//1.       10
//        /  \
//       5   14
//      /    / \
//     1    11 20

//2.

class Node{
    let value: Int
    var leftChild: Node?
    var rightChild: Node?
    
    init(value: Int, leftChild: Node?, rightChild: Node?) {
        self.value = value
        self.leftChild = leftChild
        self.rightChild = rightChild
    }
    
}

// left branch
let oneNode = Node(value: 1, leftChild: nil, rightChild: nil)
let fiveNode = Node(value: 5, leftChild: oneNode, rightChild: nil)

// right branch

let elevenNode = Node(value: 11, leftChild: nil, rightChild: nil)
let twentyNode = Node(value: 20, leftChild: nil, rightChild: nil)
let fourteenNode = Node(value: 14, leftChild: elevenNode, rightChild: twentyNode)

// root

let tenRootNode = Node(value: 10, leftChild: fiveNode, rightChild: fourteenNode)

// QUESTION: Implement a function that searches through this tree for a particular search value if the value exists return true

func search(node: Node?, searchValue: Int) -> Bool{
    if node == nil{
        return false
    }
    if node?.value == searchValue {
        return true
    } else if searchValue < node!.value{
       return search(node: node?.leftChild, searchValue: searchValue)
    } else {
        // recursion = calling a function inside itself
        return search(node: node?.rightChild, searchValue: searchValue)
    }
}

search(node: tenRootNode, searchValue: 5)



/// WHAT'S THE POINT:
//Recursive functions have to run fewer iterations of themselves to accomplish the same end as a linear function. In short, recursive functions do the same work as linear functions just more efficiently.
