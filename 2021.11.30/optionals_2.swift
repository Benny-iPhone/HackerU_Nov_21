import Foundation

//
// Usage - contcat strings
// 'if let' syntax
//

// for example: UI provides us optional String
//let textField = UITextField()
//textField.text // text of textField is String?

let firstName: String = "Benny"
let middleName: String? = "😀"//nil
let lastName: String? = nil//"Davidovitz"

var fullname: String = ""
fullname += firstName //Valid, we can add a String to a String
print(fullname)

if middleName != nil {
  fullname += " "
  fullname += middleName! //'!' - force unwrap, this is not a nil
}

print(fullname)

if let str = lastName { //set value to str if not nil, str is not an optional
  fullname += "    "
  fullname += str
} else {
  print("lastName is nil")
}

print(fullname)

//
// Usage - default value
//

let value = Int("12") //Int from String is Optional Int (Int?)
//if left expression '??' is nil, set the value to the right expression => value1 is Int, not an optional
let value1 = Int("a") ?? 0

// default value for a number from array
var arr: [Int] = []
let firstValue = arr.first ?? 0 //Int

let mName = middleName ?? "" //mName is String, not String?

//
// 'guard let' syntax
//

// "abcba"
//use guard to avoid crashes, if string is empty leave the function
func isPolindrom(str: String) -> Bool { "אבא"
  //if style
  if !(str.count > 0) {
    return false
  }
  //guard style
  guard str.count > 0 else {
    return false
  }
  //TODO
  return true
}

//use guard to get rid of optional
func findMaxIntValue(arr: [Int]?) -> Int {
  //make sure that arr is not nil
  guard let arr = arr else {
    return -1
  }
  //from this point forward, arr is not optional
  guard arr.count > 0 else {
    return -1
  }

  return 8
}
