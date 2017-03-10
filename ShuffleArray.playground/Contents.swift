//: Playground - noun: a place where people can play

import UIKit
//O(n^2) = not an efficient algo
//var list = [1,2,3,4,5,6,7]
//
//extension Array{
//    public mutating func shuffle(){
//        var temp = [Element]()
//        while !isEmpty{
//            let i = Int(arc4random_uniform(UInt32(count)))
//            let object = remove(at: i)
//            temp.append(object)
//            
//        }
//    self = temp
//    
//    }
//}
//
//list.shuffle()

var list = [1,2,3,4,5,6,7]
// O(n) times super good
extension Array{
    public mutating func betterShuffle(){
        for i in stride(from: count - 1, to: 1, by: -1){ //step through the array
            let random = Int(arc4random_uniform(UInt32(i + 1))) // generate a random number in the range of the array using the array's values
            if i != random{
                swap(&self[i], &self[random]) // swap the old values for the new random values
            }
        }
        
    }
}

list.betterShuffle()


