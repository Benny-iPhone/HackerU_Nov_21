//
//  ViewController.swift
//  HomeworkCalculator
//
//  Created by Benny Davidovitz on 21/12/2021.
//

import UIKit

class ViewController: UIViewController {
    //keep reference to UI Elements, you can name it however you wish, just use a meaningful name
    @IBOutlet weak var firstNumberTextField: UITextField!
    @IBOutlet weak var secondNumberTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    //reference to the buttons, in order to identify them in buttonAction function
    @IBOutlet weak var plustButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var multiButton: UIButton!
    @IBOutlet weak var divButton: UIButton!
    
    //a function provided by xCode template, very handy to do initial setup when view loaded (only called once)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //the function which the buttons trigger when clicked
    @IBAction func buttonAction(_ sender: UIButton) {
        //step 1: read the numbers, if no valid numbers are present, abort the function
        /*
         guard statement 'let num1 = Int(firstNumberTextField.text ?? "")' result a non null value, num1 is a valid Int
         if condition failed, else code will be executed.
         ?? - fallback
         if left expression is nil, take the right one
         if firstNumberTextField.text => nil then take ""
         */
        guard let num1 = Int(firstNumberTextField.text ?? "") else {
            resultLabel.text = "invalid first number"
            return
        }
        
        guard let num2 = Int(secondNumberTextField.text ?? "") else {
            resultLabel.text = "invalid second number"
            return
        }
        
        //step 2: do the math according to the button (sender)
        let result: Int
        //sender is the button that clicked, see line 29
        switch sender {
        case plustButton:
            result = num1 + num2
        case minusButton:
            result = num1 - num2
        case multiButton:
            result = num1 * num2
        case divButton:
            //if num2 is 0, abort the function
            guard num2 != 0 else {
                resultLabel.text = "can not divide by 0"
                return
            }
            result = num1 / num2
        default:
            //should not happen, we covered all possible cases
            return
        }
        
        //step 3: display the result
        //result has to be set prior to using it
        resultLabel.text = "\(result)"
    }
    


}

