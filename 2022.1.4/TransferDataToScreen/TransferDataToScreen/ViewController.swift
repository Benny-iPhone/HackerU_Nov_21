//
//  ViewController.swift
//  TransferDataToScreen
//
//  Created by Benny Davidovitz on 04/01/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //type 'prepare' auto-complete will suggest you
    //notify when storyboard is ready for transition (push SecondViewController in our case)
    //next screen is ready, not displayed yet, UI was not build yet
    //init called on SecondViewController, viewDidLoad did not happen yet
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if destination view controller is SecondViewController
        if let secondVC = segue.destination as? SecondViewController {
            //we can not assign to label, label is nil at this point
            //secondVC.label.text = self.textField.text
            secondVC.text = self.textField.text
        }
    }

}

