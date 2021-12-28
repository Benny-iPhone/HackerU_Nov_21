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
    
    //reference to UI elements
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityStepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        //create item
        let newItem = Item(name: name, price: price, quantity: quantity)
        //add to list
        ListManager.shared.add(item: newItem)
        
        //go back to list
        //self.navigationController?.popViewController(animated: true)
    }
    
}
