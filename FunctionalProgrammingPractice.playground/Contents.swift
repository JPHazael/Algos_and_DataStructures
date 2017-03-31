//: Playground - noun: a place where people can play
// From a Ray Wanderlich Tutorial on Functional Programming available here: https://www.raywenderlich.com/157123/introduction-functional-programming-swift-2



import Foundation



enum RideCategory: String {
    case family
    case kids
    case thrill
    case scary
    case relaxing
    case water
}

typealias Minutes = Double
struct Ride {
    let name: String
    let categories: Set<RideCategory>
    let waitTime: Minutes
}


let parkRides = [
    Ride(name: "Raging Rapids", categories: [.family, .thrill, .water], waitTime: 45.0),
    Ride(name: "Crazy Funhouse", categories: [.family], waitTime: 10.0),
    Ride(name: "Spinning Tea Cups", categories: [.kids], waitTime: 15.0),
    Ride(name: "Spooky Hollow", categories: [.scary], waitTime: 30.0),
    Ride(name: "Thunder Coaster", categories: [.family, .thrill], waitTime: 60.0),
    Ride(name: "Grand Carousel", categories: [.family, .kids], waitTime: 15.0),
    Ride(name: "Bumper Boats", categories: [.family, .water], waitTime: 25.0),
    Ride(name: "Mountain Railroad", categories: [.family, .relaxing], waitTime: 0.0)
]


extension RideCategory: CustomStringConvertible {
    var description: String {
        return rawValue
    }
}

extension Ride: CustomStringConvertible {
    var description: String {
        return "⚡️Ride(name: \"\(name)\", waitTime: \(waitTime), categories: \(categories))"
    }
}

extension Ride: Comparable {
    static func <(lhs: Ride, rhs: Ride) -> Bool {
        return lhs.waitTime < rhs.waitTime
    }
    
    static func ==(lhs: Ride, rhs: Ride) -> Bool {
        return lhs.name == rhs.name
    }
}




// The function below represents the classical(aka Imparitive) method of programing where data is assigned to a variable and then mutated.

//func sortedNames(of rides: [Ride]) -> [String] {
//    var sortedRides = rides
//    var key: Ride
//    
//    // 1 loop through the a dictionar of rides and get all of there names
//    for i in (0..<sortedRides.count) {
//        key = sortedRides[i]
//        
//        // 2 loop through the list of names backwords sorting them in ascending order
//        for j in stride(from: i, to: -1, by: -1) {
//            if key.name.localizedCompare(sortedRides[j].name) == .orderedAscending {
//                sortedRides.remove(at: j + 1)
//                sortedRides.insert(key, at: j)
//            }
//        }
//    }
//    
//    
//    // 3 append the now sorted list of names into a mutable array of strings
//    var sortedNames = [String]()
//    for ride in sortedRides {
//        sortedNames.append(ride.name)
//    }
//    
//    //return the array of sorted names
//    return sortedNames
//}



func waitTimeIsShort(ride: Ride) -> Bool {
    return ride.waitTime < 15.0
}


//Functions that accept or return other functions are called higher order functions. In this case "filter" accepts "waitTimeIsShort" as a parameter. Therefore, "filter" is a higher order function. In Swift a function is just a named closure, so you can pass a closre as a parameter to a higher order function.


var shortWaitTimeRides = parkRides.filter(waitTimeIsShort)


//In Swift a function is just a named closure, so you can pass a closre as a parameter to a higher order function. Like in the example below.

shortWaitTimeRides = parkRides.filter { $0.waitTime < 15.0 }

//print(shortWaitTimeRides)


//In the example below we reduce the amount of code needed to sort the ride names alphbetically by employing the higher level function "map" and the Array type's .sorted protocol.

func sortedNames(of rides: [Ride]) -> [String] {
    let rideNames = parkRides.map { $0.name }
    return rideNames.sorted(by: <)
}

//print(sortedNames(of: parkRides))


// The "reduce" methodtakes two parameters. The first is a starting value of a generic type Element, and the second is a function that combines a value of type Element with an element in the collection to produce another value of type Element. In this case the function starts at zero and then adds each ride's wait time to the total wait times of all rides.

let totalWaitTime = parkRides.reduce(0.0) { (total, ride) in total + ride.waitTime }
//print(totalWaitTime)

//One of the more advanced techniques in Functional Programming is using partial functions. This concept allows you to encapsulate one function within another, which allows you to define a part of a function while passing another component of it as a parameter.


// In the example below, the "filter" method accepts a RideCategory as its parameter and returns a function that filters a [Ride] based on the provided category. Notice that kidRideFilter is a constant and never mutates.



func filter(for category: RideCategory) -> ([Ride]) -> [Ride] {
    return { (rides: [Ride]) in
        rides.filter { $0.categories.contains(category) }
    }
}


let kidRideFilter = filter(for: .kids)
//print(kidRideFilter(parkRides))

// Pure functions, like the example below, must always satisfy two criteria. 1) The function always produces the same output when given the same input, e.g., the output only depends on its input. 2) The function creates zero side effects outside of it. "ridesWithWaitTimeUnder" is a pure function because its output is always the same when given the same wait time and the same list of rides. Using pure functions is important for unit testing because their results are replicatable which makes writing tests much easier.

func ridesWithWaitTimeUnder(_ waitTime: Minutes, from rides: [Ride]) -> [Ride] {
    return rides.filter { $0.waitTime < waitTime }
}


var shortWaitRides = ridesWithWaitTimeUnder(15, from: parkRides)
//assert(shortWaitRides.count == 2, "Count of short wait rides should be 2")
//print(shortWaitRides)


//Pure functions are closely related to the concept of referential transparency. An element of a program is referentially transparent if you can replace it with its definition and always produce the same result. It makes for predictable code and allows the compiler to perform optimizations. Pure functions satisfy this condition.

// Take a look at the code below it maintains the same functionality as ridesWithWaitTimeUnder but excludes the functions definition and only maintains the function's body.

//shortWaitRides = parkRides.filter { $0.waitTime < 15 }
//assert(shortWaitRides.count == 2, "Count of short wait rides should be 2")
//print(shortWaitRides)





//This algorithm first picks a a pivot element. Then the collection is divided into two parts; one part holding all the elements that are less than or equal to the pivot, the other holding the remaining elements greater than the pivot. Recursion is then used to sort the two parts. Note that by using recursion, there is no need for a mutable state.

extension Array where Element: Comparable {
    func quickSorted() -> [Element] {
        if self.count > 1 {
            let (pivot, remaining) = (self[0], dropFirst())
            let lhs = remaining.filter { $0 <= pivot }
            let rhs = remaining.filter { $0 > pivot }
            return lhs.quickSorted() as [Element] + [pivot] + rhs.quickSorted()
        }
        return self
    }
}

//print(parkRides.quickSorted())
//print(parkRides)


//EXAMPLE CASE: A family with young kids wants to go on as many rides as possible between frequent bathroom breaks, so they need to find which kid-friendly rides have the shortest lines. Help them out by finding all family rides with wait times less than 20 minutes and sort them by wait time (ascending).

// Using the classical(Imparitive) approach you might solve this problem with an algorithm that looks something like this:
var ridesOfInterest: [Ride] = []
for ride in parkRides where ride.waitTime < 20 {
    for category in ride.categories where category == .family {
        ridesOfInterest.append(ride)
        break
    }
}

var sortedRidesOfInterest = ridesOfInterest.quickSorted()
print(sortedRidesOfInterest)

// Using a functional approach you can preserve all of the functionality of the alforithm with only one line of code.


sortedRidesOfInterest = parkRides.filter { $0.categories.contains(.family) && $0.waitTime < 20 }.sorted(by: <)

print(sortedRidesOfInterest)

//A great place to start working with FP techniques is in your Model layer, your ViewModel layer, and anywhere your application’s business logic appears.


