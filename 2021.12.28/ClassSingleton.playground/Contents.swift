import UIKit

/*
 Singleton, Shared-Instance => Instance that can access from anywhere, globally
 Singleton - do not allow more instances.
 Shared-Instance - there is one (or more) global instance, and can be more.
 */

//Singleton

//we do not want more then 1 instance, multiple objects address the same (Sql) file is risky
class DatabaseManager {
    
    //this is the global instance
    static let singleton = DatabaseManager()
    
    //no one else can call init
    private init() {
        
    }
    
    //some samples functions
    func connect() {
        
    }
    
    func write(object: Any) {
        
    }
    
    func readObjects() -> [Any] {
        return []
    }
    
    
}

DatabaseManager.singleton.connect()
DatabaseManager.singleton.write(object: 5)

//init is private, we can not create more instances
//let db2 = DatabaseManager()

/*
 Shared instance, one instance is global, and can be more
 */

class User {
    static let current: User = User()
    var nickname: String = ""
    
    func readUsersFrom(file: String) -> [User] {
        //just return array of User with 2 users
        //User() - create a new user
        return [User(), User()]
    }
}

User.current.nickname

let networkUser = User()
networkUser.nickname = "nicky"
//=== check if same instance
networkUser === User.current

//add support to ==
//Equatable is protocol, with some methods in it.
//Equatable provide default implementation
extension User: Equatable {
    //provide implementation for ==
    //lhs = left expression
    //rhs = right expression
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.nickname == rhs.nickname
    }
    
}

// == compare content
// === compare address in memory
networkUser.nickname
User.current.nickname
networkUser == User.current
