import Foundation

//1
//num is internal and external name of the argument
func isPrimary(num: Int) -> Bool {
  if num <= 3 {
    return true
  }

  //..< do not include num
  for i in 2..<(num / 2) {
    if num % i == 0 {
      return false
    }
  }

  return true
}
//... => include 100
for i in 1...100 {
  print("\(i) isPrimary: \(isPrimary(num: i))")
}

//2
//of - external name
//num - internal name
func sumDigits(of num: Int) -> Int {
  var sum = 0
  var num = num //argument is a let, so we manipulate it to var

  while num != 0 {
    //extract most right digit, add it to sum
    sum += num % 10
    //divide num by 10 until it reaches 0
    num /= 10
  }

  return sum
}

print("sumDigits of 1234 is: \(sumDigits(of: 1234))")

func sumDigits2(of num: Int) -> Int {
  var sum = 0
  let str = String(num)
  for ch in str {
    //! - force unwrap optional = hey compiler, this is not null
    sum += Int(String(ch))!
  }
  return sum
}

/*
num: 1,234
String(num): "1234"
compactMap: [1,2,3,4]
reduce: 1 + 2 + 3 + 4
*/
func sumDigits3(of num: Int) -> Int {
  String(num)
    .compactMap{ Int(String($0)) } //Interate characters, converting them to In
    .reduce(0) { $0 + $1 }
}

print(sumDigits3(of: 1234))

///
/// 3
///

func countVowels(str: String) -> Int {
  var sum = 0
  for ch in str {
    switch ch {
      case "a","e","i","o","u":
        sum += 1
      case "A","E","I","O","U":
        sum += 1
      default:
        continue //move on to next char
    }
  }

  return sum
}

print(countVowels(str: "HEllo XYZ"))
