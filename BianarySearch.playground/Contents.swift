//: Playground - noun: a place where people can play

import UIKit



let numbers = [3,4,8,9,10,18,24,29]


//Not a very efficient way of searching because the loop runs as many times as there are indices in the array. In other words, the loop has to run (n) times to execute the search

func linearSearchForSearchValue(searchValue: Int, array: [Int])->Bool{
    for number in numbers{
        if number == searchValue{
            return true
        }
    }
    return false
    
}

linearSearchForSearchValue(searchValue: 11, array: numbers)


//Bianary search is much more efficient but you need to sort the array so that the values are ascending befor you can run it. IT will execute the function log(n) times to accomplish the search.

func bianarySearchForSearchValue(searchValue: Int, array: [Int])->Bool{
    
    var leftIndex = 0
    var rightIndex = array.count - 1
    
    while leftIndex <= rightIndex{
        
        var middleIndex = (leftIndex + rightIndex) / 2
        var middleValue = array[middleIndex]
        
        print("middle value: \(middleValue), leftIndex: \(leftIndex), rightIndex: \(rightIndex)  range [\(array[leftIndex]), \(array[rightIndex])] ")
        if middleValue == searchValue{
            return true
        }
        if searchValue < middleValue {
            rightIndex = middleIndex - 1
        }
        if searchValue > middleValue{
            leftIndex = middleIndex + 1
            
        }
    }
    return false
}


bianarySearchForSearchValue(searchValue: 24, array: numbers)


