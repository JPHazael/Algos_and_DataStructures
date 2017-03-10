//: Playground - noun: a place where people can play

import UIKit



class Node<T>{
    var value: T
    var next: Node?
    
    init(value: T) {
        self.value = value
    }
}




class Stack<T>{
    
    var top: Node<T>?
    
    
    func push(_ value: T){
        let oldTop = top
        top = Node(value: value)
        top?.next = oldTop
        
    }
    
    func pop() -> T? {
        let currentTop = top
        top = top?.next
        return currentTop?.value
    }
    
    func peek() -> T?{
        return top?.value
    }
    
}


struct User{
    let name: String
    let username: String
    
}

let me = User(name: "Jeff", username: "@BigDawg")
let you = User(name: "Not Jeff", username: "@SomeoneElse")

let UsersStack = Stack<User>()

UsersStack.push(me)
UsersStack.push(you)

UsersStack.peek()?.username



let stack = Stack<Int>()

stack.push(1)
stack.push(2)
stack.peek()
stack.push(3)

let firstPop = stack.pop()
stack.peek()
let secondPop = stack.pop()
let thirdPop = stack.pop()

