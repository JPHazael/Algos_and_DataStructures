//: Playground - noun: a place where people can play

import UIKit

class Person{
    var name: String
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Person \(name) is being deinitialized")
    }
}

class Apartment{
    let number: Int
    
    //set tenant to weak to avoid memory leaks and retention cycles
    var tenant: Person?
    init(number:Int) {
        self.number = number
    }
}


var bob:Person? = Person(name: "Bob")
let me = Person(name: "Jeff")

let apt = Apartment(number: 123)

apt.tenant = bob

bob = nil


//in order to prevent memory leaks you have to deint all strong connections together
// or you can set tenant to a "weak var"
//apt.tenant = nil

