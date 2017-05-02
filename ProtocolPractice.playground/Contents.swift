//: This code and comments is based on a Ray Wanderlich tutorial available here: https://www.raywenderlich.com/148448/introducing-protocol-oriented-programming


// Define two base protocols with necessary get only properties.
protocol Bird: CustomStringConvertible {
    var name: String { get }
    var canFly: Bool { get }
}

protocol Flyable {
    var airspeedVelocity: Double { get }
}


// Create a value type, in this case a struct, that conforms to both protocols. Implement protocols using the same syntax as class inheritence.


struct FlappyBird: Bird, Flyable {
    let name: String
    let canFly = true
    // These two properties conform to the bird protocol
    let flappyAmplitude: Double
    let flappyFrequency: Double
    
    var airspeedVelocity: Double {
        return 3 * flappyFrequency * flappyAmplitude
    }
    // This conforms to the flyable
}


// Contrast our FlappyBird, which conforms to the Bird and Flyable protocols, with the Penguin struct, which only conforms with the Bird protocol.

struct Penguin: Bird {
    let name: String
    let canFly = false
}

// Finally, our Swift Bird conforms to both protocols but is even faster than the Flappy Bird.

struct SwiftBird: Bird, Flyable {
    var name: String { return "Swift \(version)" }
    let version: Double
    let canFly = true
    
    // Swift is FASTER every version!
    var airspeedVelocity: Double { return version * 1000.0 }
    
}

// if we have multiple objects with similar implementations of a protocol, we can use the value type enum and switch statements to provide customizable implementations.

enum UnladenSwallow: Bird, Flyable {
    case african
    case european
    case unknown
    
    var name: String {
        switch self {
        case .african:
            return "African"
        case .european:
            return "European"
            //*How do we know whether this unknown swallow can fly or not? is there some way to not give it the same default behavior as the other swallows?
        case .unknown:
            return "What do you mean? African or European?"
        }
    }
    
    var airspeedVelocity: Double {
        switch self {
        case .african:
            return 10.0
        case .european:
            return 9.9
        case .unknown:
            fatalError("You are thrown from the bridge of death!")
        }
    }
}

// Now that we have defined our protocols and we have some objects that can implement them. The next step is to extend the protocol to provide defualt implementations for some of the properties and methods. For example, our swallows are all flyables so they default to canFly = True.

extension Bird {
    // Flyable birds can fly!
    var canFly: Bool { return self is Flyable }
}

//* We can also ectend out UnladenSwallow type to account for the potential lack of flyability of an unknown swallow.


extension UnladenSwallow {
    var canFly: Bool {
        return self != .unknown
    }
}

// here are some sample implementations. Note that we have to initialize our king penguin with a name in order to conform to the Bird protocol. we do not need to initialize a value for can fly becauase it gets the default implementation from our Bird extension.

UnladenSwallow.unknown.canFly
UnladenSwallow.african.canFly
Penguin(name: "King Penguin").canFly

// You can also utilize protocols from the standard library and also define default behaviors. First we make our bird protocol inherit from CustomStringConvertable like this "Bird: CustomStringConvertable{". Then we can extend CustomStringConvertable only for cases where the implementation of CSC is a Bird.


extension CustomStringConvertible where Self: Bird {
    var description: String {
        return canFly ? "I can fly" : "Guess I’ll just sit here :["
    }
}

UnladenSwallow.african

// Next, we can add a reference type!! Because they can have protocol compliance, too.

class Motorcycle {
    
    // structs get a simple property initializer for free, but when we write a class we also have to include the initializer.
    
    init(name: String) {
        self.name = name
        speed = 200
    }
    var name: String
    var speed: Double
}

// Now we can have a Race! But how do we know which birds are good at racing? and how do we know how fast they can go? Protocols are always the answer!

protocol Racer {
    var speed: Double { get }  // speed is the only thing racers care about
}

//But our Birds already implemented protocols how can we have a model that implements a protocol after initialization? The answer is we can use extensions to achieve something called "retroactive modeling"

extension FlappyBird: Racer {
    var speed: Double {
        return airspeedVelocity
    }
}

extension SwiftBird: Racer {
    var speed: Double {
        return airspeedVelocity
    }
}

extension Penguin: Racer {
    var speed: Double {
        return 42  // full waddle speed
    }
}

extension UnladenSwallow: Racer {
    var speed: Double {
        return canFly ? airspeedVelocity : 0
    }
}

// We can also extend classes to comply with protocols. In this case our motorcycle already has a "speed" property. So all we have to do is include the name of the protocol we want it to conform to in an extension.

extension Motorcycle: Racer {}

// Now we can create the model layer of our race by using an array of diverse types (value and reference) that all conform to the Racer protocol.

let racers: [Racer] =
    [UnladenSwallow.african,
     UnladenSwallow.european,
     UnladenSwallow.unknown,
     Penguin(name: "King Penguin"),
     SwiftBird(version: 3.0),
     FlappyBird(name: "Felipe", flappyAmplitude: 3.0, flappyFrequency: 20.0),
     Motorcycle(name: "Giacomo")
]

// We can also write a function to determine who the fastest racer is.

func topSpeed(of racers: [Racer]) -> Double {
    return racers.max(by: { $0.speed < $1.speed })?.speed ?? 0
}

topSpeed(of: racers) // Of course Swift is the fastest!!

// Next suppose we want to know the top speed of a subrange of our racers instead of all of them. We can accomplish this by including a generic type in the function definition.

func topSpeed<RacerType: Sequence>(of racers: RacerType) -> Double
    // because we've defined the RacerType as something that must be a sequence, we know that the RacerTypes
    // be iterated through
    
    where RacerType.Iterator.Element == Racer {
        // next we defined what we are going to use to iterate through the RacerTypes. In this case, we can 
        // iterate by Racer. Meaning each "step" in the iteration must conform to the Racer protocol. In this case every member of our Racers array does that.
        
        
        return racers.max(by: { $0.speed < $1.speed })?.speed ?? 0
        //Finally we return the Racers in our range ordered by speed and if they don't have a speed we use optional defaulting to set it to zero.
}

topSpeed(of: racers[1...3])

// But that implementation is a little clunky. We can make it better by using extensions.

extension Sequence where Iterator.Element == Racer {
    func toppSpeed() -> Double {
        return self.max(by: { $0.speed < $1.speed })?.speed ?? 0
    }
}

racers.toppSpeed()
racers[1...3].toppSpeed()

//// let's write a protocol to give our Racers a score
//
//protocol Score {
//    var value: Int { get }
//}
//
////Then we can use value types to implement that protocol indifferent ways. Suppose we have multiple scores for Racing, Style, and Cuteness.
//
//struct RacingScore: Score {
//    let value: Int
//}

// Now suppose that we want to perform arithmetic operations on our scores. Say the total score equals the Racing score * the Style score + Cuteness. We would need our Score protocol to implement other protocols to make it comparable and potentially Operatable, like so.

protocol Score: Equatable, Comparable {
    var value: Int { get }
}

struct RacingScore: Score {
    let value: Int
    
    static func ==(lhs: RacingScore, rhs: RacingScore) -> Bool {
        return lhs.value == rhs.value
    }
    
    static func <(lhs: RacingScore, rhs: RacingScore) -> Bool {
        return lhs.value < rhs.value
    }
}

// Now we can compare the scores. The code below should retun True because 150 is greater than or equal to 130.

RacingScore(value: 150) >= RacingScore(value: 130)






