import UIKit

//Dictionary is map, storing value using key-value
//unlike array that stores values using index system

var arr: [Int] = [1,2,3]
arr[0] = 5


//empty dictionary, key is String, value can be anything
var dict1: [String:Any] = [:]

//we can set whatever we want inside
//"id" - key, "123" - value
dict1["id"] = "123"
dict1["name"] = "david"
dict1["age"] = 50
dict1["avg_score"] = 31.56
dict1["grades"] = [1,2,3,100,500,-1000]

print(dict1)

//we can read using the key, value is optional Any
let val: Any? = dict1["id"] //String
//nil, value does not exist for the specified key
let nonExitVal = dict1["iddddd"] //nil

let val2 = dict1["grades"] //[Int] ,array of Int


//double check: 1. value is exist, 2. value is Int
//if value does not exist, or not Int, the check will fail
//as? = casting, try to cast, if fail -> nil
if let age = dict1["age"] as? Int {
    print(age * 2)
    dict1["age"] = age * 2
}

if let gradesVal = dict1["grades"], //check if value exist | , => and
  let grades = gradesVal as? [Int] { //check if fetched value is [Int]

  }

print(dict1)

//this dictionary key is of type Int, value if of type Int
//var dict2: [Int:Int] = [:]
//dict2[3] = 5
