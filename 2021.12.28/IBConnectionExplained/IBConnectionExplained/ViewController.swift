//
//  ViewController.swift
//  IBConnectionExplained
//
//  Created by Benny Davidovitz on 28/12/2021.
//

import UIKit

class ViewController: UIViewController {

    //old-decleration
    //@IBOutlet weak var label: UILabel!
    //modifing the outlet label, without updating the Main.storyboard connection (see connection inspector) will cause a crash, stops on AppDelegate.swift
    //Crash log starts with:
    //Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[<IBConnectionExplained.ViewController 0x7fa5c70089c0> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key label.'

    //So
    //1. remove old connection
    //2. reconnect to new name
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //old function name
    //@IBAction func buttonPressed(_ sender: Any) {
    //new function name
    //bear in mind to update the connection in the storyboard
    //if you fail to do so, the app will crash upon clicking the button
    //Crash log starts:
    //-[IBConnectionExplained.ViewController buttonPressed:]: unrecognized selector sent to instance
    @IBAction func buttonClicked(_ sender: Any) {
        //if connection is not hooked, code will crash for addressing null
        myLabel.text = "hello world"
    }
    


}

