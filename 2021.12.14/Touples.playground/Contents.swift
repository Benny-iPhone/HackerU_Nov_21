import UIKit
import Darwin

/*
 Touple
 bunch of object
 can be used for lazy creation of type
 */

//Touple, 2 objects, first is Int, second is String
let t = (1,"one")

//Touple with 2 Doubles
let t2 = (3.0, 4.0)

//Touple with 3 elements
let t3 = (1, 2.0, true)

//Touble object can have name
let cardTouple = (value: 11, name: "Jack")

//the 2 index (3rd) object of t3
t3.2

cardTouple.0
cardTouple.value

//An example
//function that return ceil and floor of a value
//ceil, the smallest integer and bigger than or equal the value
//ceil(3.5) => 4
//ceil(4.2) => 5
//ceil(5.0) => 5
//ceil(-1.5) => -1

//floor -  the bigger number that is smalle or eual to the value
//floor(3.5) => 3
//floor(4.2) => 4
//floor(5.0) => 5
//floor(-1.5) => -2

func ceilAndFloor(value: Double) -> (ceil: Double, floor: Double) {
    return (ceil(value), floor(value))
}

ceilAndFloor(value: -1.5)
ceilAndFloor(value: 4.5).floor
ceilAndFloor(value: 4.5).ceil

//a function to return if id num is valie, and check digit
struct IdCheckResult {
    let isValid: Bool
    let checkDigit: Int
}

func checkId2(id: String) -> IdCheckResult {
    return IdCheckResult(isValid: true, checkDigit: 0)
}
func checkId(id: String) -> (Bool,Int) {
    return (true,0)
}
