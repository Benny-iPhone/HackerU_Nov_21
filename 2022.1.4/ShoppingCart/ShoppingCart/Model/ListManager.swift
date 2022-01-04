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
    
    func delete(at index: Int) {
        //guard that index is a valid
        //~= in range => (0..<len contains index)
        guard 0..<list.count ~= index else {
            return
        }
        list.remove(at: index)
    }
    
    func update(item: Item) {
        //find index
        //list.firstIndex(where: <#T##(Item) throws -> Bool#>)
        //list.firstIndex { checkItem in return checkItem.id == item.id }
        //$0 - first argument of function
        guard let index = list.firstIndex(where: { $0.id == item.id }) else {
            return
        }
        //update
        list[index] = item
    }
}
