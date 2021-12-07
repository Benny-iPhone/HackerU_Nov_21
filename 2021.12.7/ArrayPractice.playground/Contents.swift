import Foundation

//define an empty array of Int

//var - unlike let which is constant, var is mutatable
//name is array
//type is [Int] - array of Int
//= starts with empty
var array: [Int] = []

/*
class MyClass {
    
}

var arr2: [MyClass] = []
*/
/*
 Add 100 random numbers in range 1000...10000 to that array
 */

//example how to generate a random number
//let - a constant
//aNum - the name of the constant
//type is Int, because value is Int
//1000...10000 - range between 1,000 and 10,000
//10_000 _ is meaningless, just to clarify the value for us
let aNum = Int.random(in: 1_000...10_000)
//any utf8 can be used to name your variable, constants, functions, classes, enum, struct, protocol
let מספר = 5
let 🔥🔥🔥 = 7

// using .append() we can add object to the end of array
//array.append(aNum)
//using .insert(_ at:) we can add an object to specified index of the array
//array.insert(aNum, at: 0)

//we can use _ when index name is unused
for _ in 0..<100 { //100 times
    //generate a new random value
    let value = Int.random(in: 1_000...10_000)
    //add the generated value to array
    array.append(value)
}

/*
 Operations
 */

//count - how many elements
//\( expression ) is how we embed value of expression in string
print("count of elements in array is \(array.count)")

//update elements in array
//object in index 2 is now -10
print("before \(array[2])")
array[2] = -10
print("after \(array[2])")

//for every odd number make is even
for i in 0..<array.count { //run over valid indexes of the array (0..<100)
    if array[i] % 2 != 0 { //value at array[i] is odd (אי זוגי)
        print("before \(i) \(array[i])")
        //array[i] = array[i] + 1
        array[i] += 1 //increment the value by 1
        print("after \(i) \(array[i])")
    }
}
/*
 //side questions asked by students
var stringArray: [String] = []
stringArray.append("5")

//array of any type
var miscArray: [Any] = []
miscArray.append(5)
miscArray.append(1.3)
miscArray.append(true)
miscArray.append(stringArray)

miscArray

//2 dimenssion array
let matrix: [[Any]] = [
    [1,2,3],
    [4.0, 5.1, 3.4]
]
*/
//remove object from array

//array.removeAll()
let removedValue = array.remove(at: 4) //remove object at index 4
array.removeSubrange(0...10) //remove objects at indexes 0,1,..,10
array.removeLast()
array.removeFirst()

//we can use update to remove (11) objects
array.count
array[0...10] = []
array.count
//or simply update a sequence
//array[1...3] = [10,20,30]

array.count

//func - key word
// sumArray - name of function
// _ arr: [Int] - receives an array of Int, internal name is arr, external name is not exist
// -> Int - returns Int
func sumArray(_ arr: [Int]) -> Int {
    var total = 0
    for num in arr {
        total += num
    }
    return total
}

let arraySum = sumArray(array)
//pow also does not use external
pow(2, 3) //2 power 3 = 8

//find the minimum value of the array
func minArray(_ arr: [Int]) -> Int{
    var tmp: Int = Int.max
    for val in arr {
        if val < tmp {
            tmp = val
        }
    }
    return tmp
}

minArray(array)

//avarage value in array
//avg = sum / length
//[10,15,21] => (10 + 15 + 21) / 3 = 15.3333
let avgValInt = arraySum / array.count
//now with Double
let avgValDouble = Double(arraySum) / Double(array.count)
