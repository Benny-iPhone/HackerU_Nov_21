//
//  ChatMessage.swift
//  ForumApp
//
//  Created by Benny Davidovitz on 12/04/2022.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

struct ChatMessage {
    
    static var dbRef: DatabaseReference {
        return Database.database().reference().child("chatMessage")
    }
    
    enum MessageType: String {
        case text
        case image
        case video
    }
    
    let id: String
    let text: String
    let createdBy: String
    //in ideal implementation, name is retrieved from users-list according to its id
    let createdByName: String
    let createdAt: Date
    let type: MessageType
    
    //imoprt FirebaseStorage
    //let storage: StorageRef
    
    //init? - will return nil if value is not a dictionary
    init?(id: String, value: Any) {
        guard let dict = value as? [String:Any] else {
            return nil
        }
        
        guard let typeRaw = dict["type"] as? String,
              let type = MessageType(rawValue: typeRaw) else{
                  return nil
              }
        
        self.type = type
        self.id = id
        self.text = dict["text"] as? String ?? ""
        self.createdBy = dict["createdBy"] as? String ?? ""
        let createdAtTimestamp = dict["createdAt"] as? TimeInterval ?? 0
        self.createdAt = Date(timeIntervalSince1970: createdAtTimestamp)
        self.createdByName = dict["createdByName"] as? String ?? ""
    }
    
    init(text: String) {
        self.id = UUID().uuidString
        self.text = text
        self.createdAt = Date() //now
        self.createdBy = Auth.auth().currentUser?.uid ?? ""
        self.type = .text
        self.createdByName = Auth.auth().currentUser?.displayName ?? ""
    }
    
    private var toDictionary: [String:Any] {
        return [
            "text":text,
            "createdAt":createdAt.timeIntervalSince1970, //double value
            "createdBy":createdBy,
            "type":type.rawValue,
            "createdByName":createdByName
        ]
    }
 
    func saveToDatabase(with roomId: String) {
        ChatMessage.dbRef.child(roomId).child(self.id).setValue(self.toDictionary)
    }
}
