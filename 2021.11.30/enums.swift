import Foundation

// Enum
// close group of values

enum Direction {

  case right //we can define value in a line
  case left
  case up, down //we can define multiple values in a line with ',' between them
}

var dir1 = Direction.down
var dir2: Direction = .left //when type is known, we can use shorthand

dir1 = Direction.up
dir1 = .up //compiler knows that dir1 is of Type Direction, so we can use shorthand

dir2 = .right

//var dir3 = .left //will not compile

var dir4: Direction
//print(dir4) //won't compile, dir4 is not defined yet
if (2 > 1) {
  dir4 = .left
} else {
  dir4 = .right
}

//we may set initial value to nil, if we declare optional
var dir5: Direction? = nil

//we can also define array of Direction objects
let dirArray: [Direction] = [.up, .left]

//example: map Server endpoints to a enum
enum ServerEndpoint: String {
  case getAllPosts = "api/v1/posts"
  case createNewPost = "api/v1/create"
}

ServerEndpoint.getAllPosts.rawValue //String
ServerEndpoint(rawValue: "abc") // ServerEndpoint?

//
// enum with associated raw value
//
//

//by default, first is 0
//by default, each successor case has successor value
enum Weekday: Int {
  case sunday = 1
  case monday //2
  case tuesday, wednesday, thursday, friday //3,4,5,6
  case saturday //7

  func next() -> Weekday {
    //if left expression is nil, meaning we are working on saturday => return sunday, right expression
    Weekday(rawValue: self.rawValue + 1) ?? .sunday
  }

  func previous() -> Weekday {
    guard let result = Weekday(rawValue: self.rawValue - 1) else {
      return .saturday
    }

    return result
  }

  func hebrewDescription() -> String {
    switch self {
      case .sunday:
        return "יום ראשון"
      case .monday:
        return "יום שני"
      case .tuesday:
        return "יום שלישי"
      default:
      return ""
    }
    return ""
  }
}

var d1: Weekday = .sunday
print(d1.next())
print(d1.next().next())
print(Weekday.saturday.next())
let d1int = d1.rawValue //the Int that represnt the enum value
print(d1int)

print("value of wednesday:" +  "\(Weekday.wednesday)")
print("raw valueof wednesday: \(Weekday.wednesday.rawValue)")

//Create Weekday? from Int
let d2 = Weekday(rawValue: 3) //tuesday
let d3 = Weekday(rawValue: 10) //d3 is nil, we dont have value for 10

print(d2?.hebrewDescription() ?? "")
print(d3?.hebrewDescription() ?? "no desc")
