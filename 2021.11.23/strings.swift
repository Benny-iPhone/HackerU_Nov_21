import Foundation

//you can think of String as an array of Characters
let str: String = "Hello Swift"
let str2 = "Hello Swift 😍😀"
print(str2)

//Character is single character - אות
let ch: Character = "a"
let ch1 = "b" //String
var s = ""
var m = String() //empty string

s = "abc"
s += "def"
print(s)

let count = s.count
print(count)

//Note: spaces count before and after the = need to be the same
//let s2= "hi"

print(s.contains("O"))

s += "hello world".uppercased()

print(s + " contains OL: \(s.contains("OR"))")
