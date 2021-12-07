import UIKit

//array with x elements , all the same

let emptyArray = [Int]()

//array with 100 Int all 0
var arr1 = [Int](repeating: 0, count: 100)
//array with 10 Boolean all true
var arr2: [Bool] = [Bool](repeating: true, count: 10)

var arr3 = [String](repeating: "hi", count: 6)

//array with x elements following by formula

//1...100

//convert range to array
var arr4: [Int] = Array(1...100)
//2...200
var arr5: [Int] = (1...100).compactMap { $0 * 2 }
arr5

//compactMap is function that receive a function as an argument
//The function, receives Int and return something
//For each element the function will be invoked, and all results will be summed to array
//(1...10).compactMap(<#T##transform: (Int) throws -> ElementOfResult?##(Int) throws -> ElementOfResult?#>)

func multi(_ num: Int) -> Int {
    return num * 2
}
//compact map go over (1...10) and sum the result to array, as follow
//multi(1) -> 2
//2 -> 4
//3 -> 6
//...
//10 -> 20
//[2,4,6,...,20]
(1...10).compactMap(multi(_:))

//clousre
//function is an example of clousre
(1...10).compactMap { n in //after 'in' - we start implementation
    return n * 2
}

//if we have only 1 line, return can be removed
(1...10).compactMap { n in
    n * 2
}

func doSomething() -> Bool {
    /*return*/ true
}

//we can use $0 instead of n to indicate the '0' argument - the first argument
(1...10).compactMap {
    $0 * 2
}
//we can remove the line break
(1...10).compactMap { $0 * 2 }
//var arr5: [Int] = (1...100).compactMap { $0 * 2 }

//hi1...hi100
//Int conveted to String
var arr6 = (1...100).compactMap{ "hi\($0)" }
arr6

//use compactMap to convert String array to Int array
Int("0") //Int? from String
//"1,2,3,-10,a,mm,0".components(separatedBy: ",") => Array of String
//convert a String to array of String
let strArray: [String] = "1,2,3,-10,a,mm,0".components(separatedBy: ",")
strArray
var arr7 = strArray.compactMap{ Int($0) }
arr7
//1,2,4,8,16,... 2^i
//Playground is buggy
//let arr8 = (0...10).compactMap{ pow(2, Int($0)) }.compactMap{ Int($0) }
//arr8

//0,1,4,9,16,25 x^2

//reduce

func sumArray(_ arr: [Int]) -> Int {
    var total = 0
    for num in arr {
        total += num
    }
    return total
}

//start with initial value, for each object in array, do something with temp sum and the object
arr4.reduce(0) { $0 + $1 }
//arr4.reduce(0) { $0 * $1 }

//[2,4,6,...,200]
//partialResult, object, return
//0            , 2     , 2
//2             ,4      , 6
//6             ,6      , 12
arr4.reduce(Int(0)) { partialResult, object in
    return partialResult + object
}



//plus, is a function, received 2 Int (or anything else), return Int (or anything else)
//therefore, we can send + or - or * or / to reduce
//reduce received a value, and a function
//not any function, only a function that receive 2 values and returns a value
arr4.reduce(0, +)

//10 * 2 * 3
[10,2,3].reduce(1, *)

func multiArray(_ arr: [Int]) -> Int {
    var total = 1 //not 0
    for num in arr {
        total *= num
    }
    return total
}

multiArray([4,5,6])
