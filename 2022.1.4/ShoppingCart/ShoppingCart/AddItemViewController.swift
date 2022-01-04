//
//  AddItemViewController.swift
//  ShoppingCart
//
//  Created by Benny Davidovitz on 28/12/2021.
//

import UIKit

// manage creation of item
// provide inputs
// name
// quantity
// price
// add to ListManager
class AddItemViewController: UIViewController {
    
    //an item which we might edit
    var editItem: Item?
    
    //reference to UI elements
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityStepper: UIStepper!
    
    @IBOutlet weak var mainButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //update UI if we have item
        if let editItem = self.editItem {
            //update name
            nameTextField.text = editItem.name
            //update price
            priceTextField.text = "\(editItem.price)"
            //update stepper
            quantityStepper.value = Double(editItem.quantity)
            //update stepper label
            stepperAction(quantityStepper!)
            //update screen title
            self.navigationItem.title = "Edit"
            //update button title (.normal - default state of button, unlike disabled or hightlighted = pressed)
            mainButton.setTitle("Update", for: .normal)
        } else {
            //create new item mode
            //update screen title
            self.navigationItem.title = "Create New"
            
            mainButton.setTitle("Create", for: .normal)
        }
    }
    
    //trigger: "+ -" element clicked
    //a function to be called when stepper changed
    //- update the quantityLabel with the stepper value
    @IBAction func stepperAction(_ sender: Any) {
        //stepper value is a Double
        //Create Int based on that Double value
        //Create a String based on that Int value
        //Display the string on the UI Element (quantityLabel)
        quantityLabel.text = "\(Int(quantityStepper.value))"
    }
    
    //trigger: "Create New" button clicked
    //read content of UI in order to create a new Item
    @IBAction func createAction(_ sender: Any) {
        //read name
        //check: 1) not nil, 2) not empty
        //comment: I presonllay prefer 'name.isEmpty == false' over '!name.isEmpty'
        guard let name = nameTextField.text, name.isEmpty == false else {
            return
        }
        
        //read price
        //check: 1) string is not nil, 2) string is valid Int
        guard let priceString = priceTextField.text, let price = Int(priceString) else {
            return
        }
        
        //read quantity from stepper
        let quantity = Int(quantityStepper.value)
        
        //check mode (edit / create)
        if var editItem = self.editItem {
            editItem.name = name
            editItem.price = price
            editItem.quantity = quantity
            ListManager.shared.update(item: editItem)
        } else {
            //create new mode
            //create item
            let newItem = Item(name: name, price: price, quantity: quantity)
            //add to list
            ListManager.shared.add(item: newItem)
        }
        
        //go back to list
        self.navigationController?.popViewController(animated: true)
    }
    
}
