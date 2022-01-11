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
    
    init() {
        //when ListManager loaded, try to read from disk
        self.readFromDisk()
    }
    
    //readonly, can be modify only internally
    private(set) var list: [Item] = []
    
    //In swift, we prefer computed (readonly) property rather then a function that get nothing and return a value
    //func total() -> Int { ... }
    var total: Int {
        //reduce
        //start with 0
        //for each item return $0 (temp sum) + $1(item).total
        list.reduce(0) { $0 + $1.total }
//        var sum = 0
//        for item in list {
//            sum += item.total
//        }
//        return sum
    }
    
    func add(item: Item) {
        list.append(item)
        print(list)
        //save change to disk
        self.saveToDisk()
    }
    
    func delete(at index: Int) {
        //guard that index is a valid
        //~= in range => (0..<len contains index)
        guard 0..<list.count ~= index else {
            return
        }
        list.remove(at: index)
        //save change to disk
        self.saveToDisk()
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
        //save change to disk
        self.saveToDisk()
    }
    
    //convert items to json data
    //save the data to disk
    func saveToDisk() {
        do {
            let jsonData = try JSONEncoder().encode(list)
            StorageManager().write(data: jsonData, filename: "list.json")
        } catch {
            print(error)
        }
    }
    
    //read saved data from disk (if exist(
    //convert json-data to Item array
    func readFromDisk() {
        guard let jsonData = StorageManager().read(filename: "list.json") else {
            return
        }
        
        do {
            //Item.self = > the type Item
            //[Item].self => tyhe type Item Array
            //
            self.list = try JSONDecoder().decode([Item].self, from: jsonData)
        } catch {
            print(error)
        }
    }
}
