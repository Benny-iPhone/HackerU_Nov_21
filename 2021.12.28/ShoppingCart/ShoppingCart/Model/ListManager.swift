//
//  ListManager.swift
//  ShoppingCart
//
//  Created by Benny Davidovitz on 28/12/2021.
//

import Foundation
/*
 ListManager
 - addItem(item) ✅
 - deleteItem(item)
 - updateItem(item)
 - saveToDisk()
 - readFromDisk()
 - getTotalPrice()
 */
class ListManager {
    
    static let shared = ListManager()
    
    //readonly, can be modify only internally
    private(set) var list: [Item] = []
    
    func add(item: Item) {
        list.append(item)
        print(list)
    }
    
}
