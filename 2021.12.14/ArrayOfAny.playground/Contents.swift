import UIKit

//here is an array with different types
var arr: [Any] = [1,2.0, true, "string",[1,2,3]]

//insert
enum Direction {
    case right, left
    
    func opposite() -> Direction {
        //self == this
        //condition ? if-yes :else: if-now
        //return (self == .left ? .right : .left)
        self == .left ? .right : .left
        /*
        if self == .left {
            return Direction.right
        } else {
            return Direction.left
        }*/
    }
}

var d1: Direction = .right
d1.opposite()

arr.append(Direction.left)
arr.append(8)

arr[6] = Direction.right
arr[0] is Int
arr[1] is Double
arr[1] is Character

arr
//For each Direction in array, turn it
for i in 0..<arr.count {
    //is = are you of type Direction
    if arr[i] is Direction {
        let d = arr[i] as! Direction
        arr[i] = d.opposite()
    }
}
arr

//go over all the integers in arr, double them by 2 and print in it out
//as teart as different type
//try! - cast it to the type, if fail = crash
//try? - cast it to the type, if fail = nil
for obj in arr {
    //obj is Any, let obj: Any
    //num is an optional Int
    //let num = obj as? Int
    if let num = obj as? Int {
        print("\(num) * 2 = \(num * 2)")
    }
}

//is - check for type
//as! - force treat as type
//as? - optional treat as type

let a: Any = 1.0
a is Double
let val = a as! Double
let optionalVal = a as? Double //Double?

//let intVal = a as! Int //Crash 💥
