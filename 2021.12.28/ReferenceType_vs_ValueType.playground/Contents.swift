import UIKit

/*
 Reference - there is a place in the memory with some data, and we refer (class)
 Value - the data itself (Struct, enum)
 */

struct Post { //Value type
    var title: String = ""
}

class Person { //Refernce type
    var name: String
    init(name: String) {
        self.name = name
    }
}
//modify a let
let post1 = Post(title: "A Post")
let person1 = Person(name: "John")
//not a valid command, post1 has to var if you wish to modify it
//Post is Struct, value type, we can not change the value if we decaled let - constant.
//post1.title = "title2"

var post2 = Post(title: "A Post 2")
post2.title = "title 2"

//this is legit.
//person1 is a pointer. on name edit, pointer was not moify
//only the memory referenced by it modified
person1.name = "John Snow"
//this is not valid, we can not change the pointer to refer different address in memory
//person1 = Person(name: "")

//More example
//modify a 'copy'

var p1 = Post(title: "title1")
var p2 = p1
//do not change p1.title
p2.title = "title2"

var n1 = 5
var n2 = n1 //copy, created a new Int, starting with n1 value
n2 += 1 //change n2, not the origin.
print(n1, n2)

var per1 = Person(name: "Oriel")
//per2 is a new pointer, addressing the same memory
var per2 = per1
//also change per1.name
per2.name = "Roustam"
print(p1.title, p2.title)
print(per1.name, per2.name)



