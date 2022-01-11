//
//  Item.swift
//  ShoppingCart
//
//  Created by Benny Davidovitz on 28/12/2021.
//

import Foundation

/*
 Item
 - id
 - name
 - price (?)
 - quantity
 - createdDate
 */

//Codable - Item can be encoded or decoded using JSONDecode and JSONEncoder
struct Item: Codable {
    let id: String //auto generated id
    var name: String
    var price: Int //in cents / argurot
    var quantity: Int
    let createdDate: Date //default to date of creation
    
    //    func getTotal() -> Int {
    //        return price * quantity
    //    }
    //In swift, we prefer computed (readonly) property rather then a function that get nothing and return a value
    var total: Int { price * quantity }
    
    
    init(name: String, price: Int, quantity: Int) {
        self.name = name
        self.price = price
        self.quantity = quantity
        self.createdDate = Date() //new date is now
        //UUID - Universal Unique IDentifier, just like GUID
        self.id = UUID().uuidString
    }
    

}











