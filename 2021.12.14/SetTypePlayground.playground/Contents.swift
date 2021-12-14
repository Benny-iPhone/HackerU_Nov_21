import UIKit

/*
 Set
 
 Set is like array, a collection of things (Int, String, Bool, Any ..)
 
 Differences:
 Major: Set does not repeat objects
 Minor: Set does not keep order
 */

var myArr: [Int] = []
var mySet: Set<Int> = []

myArr.append(1)
mySet.insert(1)

myArr.append(2)
mySet.insert(2)

myArr.append(1)
mySet.insert(1)

myArr //1,2,1
mySet //1,2

let arr1 = [1,2,3,1,2,4]
let s = Set(arr1)
//sorted return different sorted array
let arr1Clean = Array(s).sorted()
arr1Clean.sorted(by: >)
//unlike sort which sort the original array
myArr.sort()

var s1: Set<Int> = [1,2,3]
var s2: Set<Int> = [3,4,5]
//unite set
s1 = s1.union(s2) //[1,2,3,4,5]

//substract set (minus)
s1
var s3: Set<Int> = [3,5]
s1.subtract(s3) //s1: [1,2,4]
s1

//find intersected values (shared) values
//[1,2,4] and [3,4,5] => [4]
s1.formIntersection(s2)
