//
//  ViewController.swift
//  VendingMachine
//
//  Created by Benny Davidovitz on 14/12/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    func solution(input: Int, cost: Int) -> [Int] {
        let coins: [Int] = [100, 50, 25, 10, 5, 1]
        var resultArray: [Int] = [Int](repeating: 0, count: coins.count)
        var change = input - cost
        
        //if no change, result array of zeros
        guard change > 0 else {
            return resultArray
        }
        
        for i in 0..<coins.count {
            let coinValue = coins[i]
            resultArray[i] = change / coinValue
            change = change % coinValue
        }
        
        return resultArray
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(_ sender: Any) {
        print("button pressed")
        
        //we can not create Int from String?, therefor using '?? ""' we have String (non optional)
        //using guard, we un-wrap to Optional Int to Int, and we also check that price is positive value
        // ',' in guard statement is just like && in if statement
        guard let price = Int(priceTextField.text ?? ""), price > 0 else {
            print("invalid price")
            return
        }
        guard let input = Int(inputTextField.text ?? ""), input > 0 else {
            print("invalid input")
            return
        }
        
        //invoke the solution func, result is Int array
        let result = solution(input: input, cost: price)
        //display the result in the label
        resultLabel.text = "\(result)"
    }
    
    
    

}

