import UIKit

/*
 Class may inhertis class
 and so multiple classes may have the same functions and their implementations
 
 Struct may implement Protocol
 
 */

//Walk - able
//The protocol that define the walk functionallity
protocol Walkable {
    func walk()
}

//Extending Walkable with a new function run
//run implemented and ready to use
extension Walkable {
    
    func run() {
        print("running")
        walk()
        walk()
    }
    
}

//Dog declared Walkable
struct Dog: Walkable {
    //Therefore Dog must implement walk
    func walk() {
        print("walking")
    }
}

var snoopi = Dog()
snoopi.walk()
//Dog did not implement run by itself, Walkable extension already did
snoopi.run()

/*
 Conculsion: we can utilize protocol for shared implementation between type also Struct and Enums
 */

//declaring Codable add implementation for encoding/decoding
struct Message: Codable {
    let id: Int
    let text: String
}

let arr = [Message(id: 1, text: "hi 1"), Message(id: 2, text: "hi 2")]

let jsonData = (try? JSONEncoder().encode(arr)) ?? Data()
let jsonString = String(data: jsonData, encoding: .utf8)
print(jsonString)

if let data = try? JSONEncoder().encode(arr) {
    //...
}
