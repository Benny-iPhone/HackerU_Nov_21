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
        
        let price = priceTextField.text
        
        print("button pressed")
        resultLabel.text = "hi 👋"
    }
    
    
    

}

