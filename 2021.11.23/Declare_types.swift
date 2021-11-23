import Foundation



//Int - an integer, negative or positive values (or zero)
let num: Int = -1
//UInt => non negative
//unsigned int
let num1: UInt = 1

//Int8 - 8 bits, value can be in range of -128...127
let n1: Int8 = -100
//UInt - 8 bits, all non-negative, value can be in range of 0...255
let n2: UInt8 = 5

//+ is not defined on Int and Double
//print(x + y)
/*
Int Types
Int8, UInt8
Int16, UInt16
Int32, UInt32
Int64, UInt64

Int -> Int32/Int64, depending on target OS

00001101
*/

let x = 1 //Int
let y = 1.995 //Double
// + for Int and Double is not valid => we have to create a Double from the Int
let z = Double(x) + y
//Or in separated lines ...
let x1 = Double(x)
let z1 = x1 + y
//...
print(z)

let z3 = Int(y) + x
print(z3)

var a = 1 //a is Int
a = 2 //can set to different Int
//!! a = 2.5 !! can not set to Double, will not compile

var b = Double(a) //b is Double
