//: Playground - noun: a place where people can play

import UIKit

let numbers = [1, 2, 3, 4, 3, 3]

//1. Filter into [3,3,3] and [4,2]

let filteredThree = numbers.filter({return $0 == 3})
let filteredEven = numbers.filter({return $0 % 2 == 0})
print(filteredThree)
print(filteredEven)

// 2. transform [1,2,3,4] into [2,4,6,8] using map

let array = [1,2,3,4].map({return $0 * 2})
print(array)

//3. sum[1,2,3,4] -> 10 using reduce

let sum = [1,2,3,4].reduce(0, {sum, number in sum + number})
print(sum)
