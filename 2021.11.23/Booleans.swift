import Foundation

var b1 = true //Bool
var b2: Bool = false

let num = Int.random(in: 0...10)
let b3 = num % 2 == 0 //זוגי

print("\(num) is even: \(b3)")
//str is the argument external name
// -> Int = function should returns Int
func countChars(yoav: String) -> Int {
  return yoav.count
}
//the caller has to use 'yoav'
countChars(yoav: "hi")

//And &&
/*
t t = t
t f = f
f t = f
f f = f
*/

let a1 = true
let a2 = false

print("a1 AND a2: \(a1 && a2)") //false, a2 is false

//OR ||
/*
t t = t
t f = t
f t = t
f f = f
*/

print("a1 OR a2: \(a1 || a2)") //true, a1 is false

//NOT !
/*
t => f
f => t
*/

print("not a1 \(!a1)")

print(!a1 && a1) //always false
print(!a1 || a1) //always true

//Binary operations on Integers

var num1 = 1 // 0..0001
var num2 = 2 // 0..0010
var num3 = 3 // 0..0011
var num4 = 4 // 0..0100

//0..0001 AND 0..0010
print(num1 & num2) //0, perform AND between bits
print(num3 | num4) //7, perform OR between bits => 0..0111

print(Bool(num3 & num1 != 0)) //check if bit 1 is on in num3
