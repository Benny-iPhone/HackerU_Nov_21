//
//  DatabaseManager.swift
//  Threading
//
//  Created by Benny Davidovitz on 10/05/2022.
//

import Foundation

struct Item {
    let id: Int
    let name: String
}

class DatabaseManager {
    
    static let manager = DatabaseManager()
    
    private let queue: DispatchQueue
    
    init() {
        self.queue = DispatchQueue(label: "db_queue")
    }
    
    func write(item: Item) {
        self.queue.async {
            print("writing item")
        }
    }
    
    func update(item: Item) {
        self.queue.async {
            print("updating item")
        }
    }
        
    func getAllItems() -> [Item] {
        var result: [Item] = []
        self.queue.sync {
            //read from db
            result = []
        }
        
        return result
    }
    
    
}

