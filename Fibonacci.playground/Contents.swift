//: Playground - noun: a place where people can play

import UIKit


// Fibonacci numbers are a sequence of numbers such that FsubN = (FsubN - 1) + (FsubN - 2)


// this first function is a straight forward loop and is not the cleanest possible implimentation
func fibForNumberOfSteps(steps: Int) -> [Int]{
    var sequence = [0,1]
    if steps <= 1{
        return sequence
    }
    for _ in 0...steps{
        let first = sequence[sequence.count - 2]
        let second = sequence.last!
        sequence.append(first + second)
    }
    
    return sequence
}



// This example is a little cleaner but you still have to append the [0,1] in the function call 

func fibRecursion(steps: Int, first: Int, second: Int) -> [Int]{
    if steps == 0{
        return []
    }
    return [first + second] + (fibRecursion(steps: steps - 1, first: second, second: first + second))
}


fibForNumberOfSteps(steps: 4)

[0, 1] + fibRecursion(steps: 5, first: 0, second: 1)

