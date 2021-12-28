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

struct Item {
    let id: String //auto generated id
    let name: String
    let price: Int //in cents / argurot
    let quantity: Int
    let createdDate: Date //default to date of creation
    
    init(name: String, price: Int, quantity: Int) {
        self.name = name
        self.price = price
        self.quantity = quantity
        self.createdDate = Date() //new date is now
        //UUID - Universal Unique IDentifier, just like GUID
        self.id = UUID().uuidString
    }
}











