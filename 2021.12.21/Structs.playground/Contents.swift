import UIKit

//Define structs
struct MyStruct {
    
}

//create instances
let m1 = MyStruct()

//setup properties
//struct is a structure combining few things into one
//default choice for data-types is struct, not class
struct Person {
    let name: String
    var age: Int
}

var benny = Person(name: "benny", age: 34)
benny.age += 1
benny

//struct member can be of any type, optional, other struct, optional, enum and so on
struct Article {
    let id: Int
    let title: String
    let content: String?
    let imageUrl: URL?
}
//you can use line break for readability
let article1 = Article(id: 1,
                       title: "Breaking News!!!",
                       content: "something something",
                       imageUrl: nil)

//you can use """ at start and end, and in between as much text as you wish (even line breaks)
let imageUrlString = """
https://ynet-images1.yit.co.il/picserver5/crop_images/2021/11/26/rkeK1mwAOY/rkeK1mwAOY_0_312_3000_1689_0_x-large.jpg
"""
let article2 = Article(id: 2,
                       title: "New LEAKED PHOTO",
                       content: nil,
                       imageUrl: URL(string: imageUrlString))

//struct can have properties of the structs
struct Content {
    let article: Article
    let author: Person
}

let newContent = Content(article: article1, author: benny)

/*
 struct with nested type
 for example, a struct the represent a message, like in IM app
 we want to represent message type (text, location, image, video, gif ...)
 But we want to keep the name short
 a good real example: https://developer.apple.com/documentation/uikit/uiswipegesturerecognizer/1619178-direction
*/

struct Message {
    //Kind enum is a nested type inside of Message
    //its full name is Message.Kind
    enum Kind {
        //text, image, video, location are the possible values for Kind
        case text
        case image
        case video
        case location
    }
    let id: String
    //insdie the Message, we can refer it as 'Kind'
    let kind: Kind
    
    //let text: String?
    //let url: URL?
}
//.text is shorthand of Message.Kind.text
let m0 = Message(id: "4", kind: .text)
let m2 = Message(id: "5", kind: Message.Kind.location)

//init methods

struct Car {
    let wheels: Int = 4
    let plateNumber: String = ""
}

//by default, we can init struct using its properties
//let c1 = Car(wheels: 4, plateNumber: "123")
//but, if we set default values for the properties, that we can use empty init - Car()
let c2 = Car()

struct MyCar {
    let wheels: Int
    let plateNumber: String
    //this init only takes plateNumber, and set wheels to 4
    init(plateNumber: String) {
//        self.plateNumber = plateNumber
//        self.wheels = 4
        self.init(plateNumber: plateNumber, wheels: 4)
    }
    
    //this init takes all parameters
    //self === this
    init(plateNumber: String, wheels: Int) {
        self.plateNumber = plateNumber
        self.wheels = wheels
    }
}

let myCar1 = MyCar(plateNumber: "333")
let myCar2 = MyCar(plateNumber: "444", wheels: 6)

//Init using dictionary

//assuming we got this from the web
//usually json/xml contains simple types (String, Int, Double, Bool, Array, Dictionary)
//key: String, value: Any
let postDict: [String:Any] = [
    "id":123,
    "title":"I am the first!!!!!!!!!",
    "body":"",
    "date":1640109149.0
]

//checkout https://newsapi.org/ for real example

struct Post {
    let id: Int
    let title: String
    let body: String?
    let date: Date
    let comments: [String]?
    
    //init? - an init that might fail and return nil, just like Int("abc") that throw nil back
    init?(dict: [String:Any]) {
        //post that does not contains id - is not a valid post
        
        guard let id = dict["id"] as? Int else {
            return nil
        }
        self.id = id
        //if we were tollerant to asbsence of id
        //self.id = dict["id"] as? Int ?? 0
        
        //read title from dictionary, case it to String, if not exist, or not string, set to empty string
        //dict["title"] -> Any?
        //dict["title"] as? String -> String?
        //dict["title"] as? String ?? "" -> String
        self.title = dict["title"] as? String ?? ""
        self.body = dict["body"] as? String //body is String? , so we do not have to set fallback value
        self.comments = dict["comments"] as? [String]
        //dict["date"] -> Any?
        //dict["date"] as? Double -> Double?
        //dict["date"] as? Double ?? 0 -> Double
        //Date(timeIntervalSince1970: dict["date"] as? Double ?? 0) -> Date
        self.date = Date(timeIntervalSince1970: dict["date"] as? Double ?? 0)
    }
}

if let p = Post(dict: postDict) {
    print(p.date)
}


//struct functions
struct Point {
    let x: Double
    let y: Double
    //struct can have function, p is how we refer the received point
    func distance(from p: Point) -> Double {
        return self.x - p.x
    }
}

let point1 = Point(x: 1, y: 1)
let point2 = Point(x: 4, y: 4)
//here we are using the function, passing it the other point
let distance = point1.distance(from: point2)

//if a function is changing the struct, we need the key-word mutating
struct Dog {
    let name: String
    var steps: Int
    //private(set) - readonly, only the type itself can change the value.
    private(set) var barksCounter: Int
    //if a function is changing the struct, we need the key-word mutating
    mutating func bark() {
        barksCounter += 1
    }
    
    mutating func walk() {
        steps += 1
    }
}

var fluki = Dog(name: "fluki", steps: 0, barksCounter: 0)
fluki.bark()
print(fluki.barksCounter)
//fluki.barksCounter = 5 //not compile, private(set)

//computed properties

struct Sqaure {
    //side is stored property
    var side: Double
    //we can use function, its correct and working
    func calculateArea() -> Double {
        return pow(side, 2)
    }
    
    //but, we can have computed property
    //computed property does not require storage in memory, just like a function, invoke code
    var area: Double {
        return pow(side, 2)
    }
    
}

var square1 = Sqaure(side: 5)
square1
square1.calculateArea()
square1.area

//struct objects in array
