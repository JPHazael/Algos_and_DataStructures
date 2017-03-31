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


// The function below represents the classical(aka Imparitive) method of programing where data is assigned to a variable and then mutated.

func sortedNames(of rides: [Ride]) -> [String] {
    var sortedRides = rides
    var key: Ride
    
    // 1 loop through the a dictionar of rides and get all of there names
    for i in (0..<sortedRides.count) {
        key = sortedRides[i]
        
        // 2 loop through the list of names backwords sorting them in ascending order
        for j in stride(from: i, to: -1, by: -1) {
            if key.name.localizedCompare(sortedRides[j].name) == .orderedAscending {
                sortedRides.remove(at: j + 1)
                sortedRides.insert(key, at: j)
            }
        }
    }
    
    
    // 3 append the now sorted list of names into a mutable array of strings
    var sortedNames = [String]()
    for ride in sortedRides {
        sortedNames.append(ride.name)
    }
    
    //return the array of sorted names
    return sortedNames
}




