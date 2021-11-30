import Foundation

let num: Int = 3

//Optional - can be value, or nil (null)
var num2: Int? = 4
num2 = nil

//function to find index of a value in array, shall return nil when the value is not present
func findIndexOfNumber(of value: Int, in array: [Int]) -> Int? {
  for i in 0..<array.count {
    if array[i] == value {
      return i
    }
  }

  return nil
}

//type of result is Optional Int (Int?)
let result: Int? = findIndexOfNumber(of: -30, in: [1,2,4,5])

// use case - Int value of String

let intValue1: Int? = Int("51")
let intValue2 = Int("abc") //intValue2 is also Int?

//use case - objects from array

let array: [Double] = [1.5, 3.14, 5.12, 4]
//first may return nil if array is empty
let firstDouble: Double? = array.first // .first return optional
//last may return nil if array is empty
let lastDouble = array.last //lastDouble is also Double?

//
// How to use optional
//

//let's try to sum numbers in the string, separated by ','
let str = "1,4,5,78.3,a"
//conert to array (of string)
let arr: [String] = str.components(separatedBy: ",")
print(arr)

//convert values to Double, and sum them
var sum = 0.0 //Compiler makr this to Double
for s in arr {
  let d = Double(s)
  //it is not legit to add optional Double to Double
  //sum += d
  if d != nil { //check if d is nil
    sum += d! //tell to compiler, "this is not nil"
  }
}

print(sum)
// append = add an object to the end of an array
var arr2: [Int] = [0,1]
arr2.append(3) // [0,1,3]

//using ? to avoid nil
var myArray: [Int]? = nil
myArray = [-1]
// 'myArray.append(4)' will not compile, we have to check of myArray is nil or not

//execute append only if myArray is not nil
if myArray != nil {
  myArray!.append(4)
}

//alternatively, execute append only if myArray is not nil
//if myArray is nil, code after '?' will not be executed
myArray?.append(5)
print(myArray!)
