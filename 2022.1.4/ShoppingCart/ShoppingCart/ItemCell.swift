//
//  ItemCell.swift
//  ShoppingCart
//
//  Created by Benny Davidovitz on 04/01/2022.
//

import UIKit

//we create a  subclass of UITableViewCell in order to botain custom styling of UI
//we can also take advantage of the class in order to provide specific functionllity
class ItemCell: UITableViewCell {

    //define a refence to UI elements
    //and so we will be able to update them
    //Outlet can not be made to ViewController since its a proptotpe object and not a static one.
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    //a method to populate the UI with given item
    //we will invoke this method for each item we wish to display
    //Its a good practive to have the population code here since its the cell responsability to determine the content (SOLID principles)
    //Its also good for reusability
    func populate(with item: Item) {
        nameLabel.text = item.name
        quantityLabel.text = "\(item.quantity) items"
        
        //h.w.: take a look at NumberFormatter
        //item price is in cents -> 500 = 5$, 499 => 4.99$
        //therefore we divide by 100
        priceLabel.text = "\(Double(item.price) / 100)$"
    }

}
