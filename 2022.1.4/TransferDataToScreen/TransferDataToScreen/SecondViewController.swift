//
//  SecondViewController.swift
//  TransferDataToScreen
//
//  Created by Benny Davidovitz on 04/01/2022.
//

import UIKit

class SecondViewController: UIViewController {

    //this label should display the text from first view-controller's text-field
    @IBOutlet weak var label: UILabel!
    //text is a helper to hold the data
    var text: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //lets set the text into label
        label.text = self.text
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
