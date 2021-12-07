import UIKit

var greeting = "Hello, playground"


func findMaxValForEach(in arr:[Int]) -> Int {
    var value = arr[0]
    for num in arr { //for each
        if num > value {
            value = num
        }
    }
    return value
}

func findMaxVal(in arr:[Int]) -> Int {
    var value = arr[0]
    //iterate indexes of arr
    for i in 0..<arr.count { //arr.count = length of array
        let num = arr[i]
        if num > value {
            value = num
        }
//        value = max(value, num)
    }
    return value
}

//findMaxVal(in: [1,2,3])
//findMaxVal(in: [4,0,8])
findMaxVal(in: [-90, -80, -70, -10, -20, -1])

/*
 2 - check palindrome
 */


func isPalindrome(str: String) -> Bool {
    
    let arr = Array(str) //conert to array, to avoid compiler error
    let arrayLen = arr.count
    
    for index in 0..<(arrayLen / 2) {
        guard arr[index] == arr[arrayLen - 1 - index] else {
            return false
        }
    }
    
    return true
}

isPalindrome(str: "madam")
isPalindrome(str: "xyyx")
isPalindrome(str: "abc")
