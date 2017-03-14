//: Playground - noun: a place where people can play

import UIKit

class Person{
    var name: String
    var apartment: Apartment?
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Person \(name) is being deinitialized")
    }
}

class Apartment{
    let number: Int
    
    //set tenant to weak to avoid memory leaks and retention cycles. Weak declares a variable without increasing the reference count for the property.
    var tenant: Person?
    init(number:Int) {
        self.number = number
    }
    deinit {
        print("Apartment is being deinitialized")
    }
}


var bob:Person? = Person(name: "Bob")
let me = Person(name: "Jeff")

var apt: Apartment? = Apartment(number: 123)

apt?.tenant = bob
// When we create a reference to apt from bob we create a retain cycle because niether class can deinit properly because they are holding on to strong references for each other.
bob?.apartment = apt

bob = nil

apt = nil


//in order to prevent memory leaks you have to deint all strong connections together
// or you can set tenant to a "weak var"
//apt.tenant = nil

