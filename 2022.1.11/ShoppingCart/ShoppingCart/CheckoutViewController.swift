//
//  CheckoutViewController.swift
//  ShoppingCart
//
//  Created by Benny Davidovitz on 11/01/2022.
//

import UIKit

//Display total amout to pay
//TODO: Payment using ApplePay / Stripe
class CheckoutViewController: UIViewController {

    //this label dislpays the total amount to pay
    @IBOutlet weak var amountLabel: UILabel!
    //total is Int because Item price and Quantity are Int
    var total: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //display total in amount Label using number formatter
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "EUR"
        //divide by 100 because our total is in cents
        let number = (Double(total) / 100) as NSNumber
        amountLabel.text = formatter.string(from: number)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
