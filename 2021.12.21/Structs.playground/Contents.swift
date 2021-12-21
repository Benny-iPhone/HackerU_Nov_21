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

//setup functions

//computed properties

//struct objects in array
