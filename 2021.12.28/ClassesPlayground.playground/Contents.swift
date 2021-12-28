import UIKit

/*
 Class, takes multiple types into a single type
 */
class Person {
    let name: String
    /*
    override var debugDescription: String {
        "Person: name: \(name)"
    }*/
    
    //unlike Struct , we do not have a default init
    //so we have to provide init
    
    init(name: String) {
        self.name = name
    }
}

class Dog {
    //if all propertis has default value, then we do not must to provide init
    var name: String = ""
}

/*
 A class can be extended (stored properties) using inheritance
 */
class Student: Person {
    var grade: Double = 0
}


let p1 = Person(name: "Ruben")
//p1 is of type Person
print(p1)
let d1 = Dog()
//d1 is of type Dog
d1.name = "Roger"
print(d1)
let s1 = Student(name: "Ruben2")
s1.grade = 40
print("grade: \(s1.grade)")

class Car {
    let id: String
    //private(set) - readonly
    private(set) var mileage: Int
    //value is a prive, can not be accessed from outside of the class
    private var value: Bool
    
    //init receive id, mileage is set to 0
    init(id: String) {
        self.id = id
        self.mileage = 0
        self.value = true
    }
    
    //drive may increase the mileage
    //unlike Struct, we don't have to use the keyword 'mutating'
    func drive(km: Int) {
        //stuff to do
        self.mileage += km
    }
    
}

var myCar = Car(id: "444")
myCar.drive(km: 10)
//value is private, and can not be read
//myCar.value
print(myCar.mileage)

/*
 We can extend existing class (or any other type)
 as long as we do not modify its memory size
 */

//First usage of extension: code sepration
//Second usage: extend class that I did not create
extension Car {
    //static variable, is relevant to all Cars, and not only to specific one
    //computed property
    static var mileageLimit: Int { /*return*/ 100 }
    
    //check if car can drive a given distance
    func canDrive(km: Int) -> Bool {
        return self.mileage + km <= Car.mileageLimit
    }
}

print(Car.mileageLimit)
//myCar has milage of 10km, there fore, can not exceed the limit by 91km more
print(myCar.canDrive(km: 91))
//myCar has milage of 10km, there fore, can drive 20km more
print(myCar.canDrive(km: 20))

/*
 extension for String, return is String is a valid email
 implemetaion using regex
 */

//https://stackoverflow.com/questions/29666956/validation-of-email-in-swift-ios-application/53441176

extension String {
    func isEmail()->Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}
 

let str = "a@a.com"
str.isEmail()
"b".isEmail()

/*
 UIView is a class
 UILabel, UIButton, UISlider and more are sub-classes
 if we extend UIView, we also extend all of its subclasses
 */

let label = UILabel(frame: .zero)
label.text = "hi"
label.textColor = .red

//UIView is parent class of UILabel
extension UIView {
    func changeBackgroundToRandomColor() {
        self.backgroundColor = .brown
    }
}

label.changeBackgroundToRandomColor()
label
