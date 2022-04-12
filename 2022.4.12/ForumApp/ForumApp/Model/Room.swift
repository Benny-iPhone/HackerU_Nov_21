//
//  Room.swift
//  ForumApp
//
//  Created by Benny Davidovitz on 12/04/2022.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

struct Room {
    
    static var dbRef: DatabaseReference {
        return Database.database().reference().child("rooms")
    }
    
    let name: String
    let id: String //generated-id
    let createdBy: String //user-id
    let createdAt: Date
    
    //init? - will return nil if value is not a dictionary
    init?(id: String, value: Any) {
        guard let dict = value as? [String:Any] else {
            return nil
        }
        self.id = id
        self.name = dict["name"] as? String ?? ""
        self.createdBy = dict["createdBy"] as? String ?? ""
        let createdAtTimestamp = dict["createdAt"] as? TimeInterval ?? 0
        self.createdAt = Date(timeIntervalSince1970: createdAtTimestamp)
    }
    
    init(name: String) {
        self.id = UUID().uuidString
        self.name = name
        self.createdAt = Date() //now
        self.createdBy = Auth.auth().currentUser?.uid ?? ""
    }
    
    private var toDictionary: [String:Any] {
        return [
            "name":name,
            "createdAt":createdAt.timeIntervalSince1970, //double value
            "createdBy":createdBy
        ]
    }
 
    func saveToDatabase() {
        Room.dbRef.child(self.id).setValue(self.toDictionary)
    }
    
    func removeFromDatabase() {
        Room.dbRef.child(self.id).removeValue()
    }
}
