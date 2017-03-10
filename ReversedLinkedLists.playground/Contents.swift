//: Playground - noun: a place where people can play

import UIKit

//What is a linked list? It is a list of nodes and pointers with a Head- the begining and an end.
//1->2->3->nil

//Define a class to support the list. The classs is also referred to as adata structure


class Node{
    let value: Int
    var next: Node?
    
    
    init(value: Int, next: Node?){
        self.value = value
        self.next = next
        
    }
    
}

let threeNode = Node(value: 3, next: nil)
let twoNode = Node(value: 2, next: threeNode)
let oneNode = Node(value: 1, next: twoNode)

func printList(head:Node?){
    var currentNode = head
    while currentNode != nil {
        print(currentNode?.value ?? -1)
        currentNode = currentNode?.next
    }
    
    
}

printList(head: oneNode)



//starting list
//1->2->3->nil



//intended result
//nil<-1-<2<-3

func reversedList(head: Node?) -> Node?{
    var currentNode = head
    var prevNode:Node?
    var nextNode:Node?
    
    while currentNode != nil {
        nextNode = currentNode?.next
        currentNode?.next = prevNode
        
        print("prev: \(prevNode?.value ?? -1) Current: \(currentNode?.value ?? -1) next: \(nextNode?.value ?? -1)" )
        
        prevNode = currentNode
        
        currentNode = nextNode
    }
    
    
    
    return prevNode
}


let myReverseList = reversedList(head: oneNode)

printList(head:myReverseList!)