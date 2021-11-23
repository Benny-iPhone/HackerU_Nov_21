import Foundation

let arr1: [Int] = [1,2,3]
let arr2 = [1,2,3]
let arr3: Array<Int> = [1,2,3]

var myArr: [Int] = []

for i in 1...100 { //... range inclue max value, includes 100
  if i % 2 == 0 {
    myArr.append(i) //append add an object to array
  }
}
print(myArr)

//iterate array by index
for i in 0..<myArr.count { //..< do not include max value
  print(myArr[i] * 3)
}
//iterate array 'for each'
for num in myArr {

}

var junkyard: [Any] = []

/*
7 boom
if number contains '7' => boom
if number divide by 7 => boom
let num = ..
num % 7 == 0💥

Write a for loop, from 1 to 99 (1...99)
print every 7 boom
*/
//701
func isSevenBoom(num: Int) -> Bool {
  var num = num //convert num from let to var
  if num % 7 == 0 {
    return true
  }

  while num != 0 {
    if num % 10 == 7 { //check the most right digit
      return true
    }
    num /= 10 //1601 => 160 => 16 => 1 => 0
  }

  return false
}

for i in 1...99{
//  if i % 7 == 0 || i / 10 == 7 || i % 10 == 7 {
    if isSevenBoom(num: i) {
      print("\(i): 💥 |", terminator: "")
    }
}
