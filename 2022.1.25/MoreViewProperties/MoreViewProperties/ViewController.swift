//
//  ViewController.swift
//  MoreViewProperties
//
//  Created by Benny Davidovitz on 25/01/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var targetView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //changing the view opacity according to slider value
    @IBAction func sliderAction(_ sender: UISlider) {
        targetView.alpha = CGFloat(sender.value)
    }
    
    //hides a view with animation (alpha from 1 to 0)
    @IBAction func fadeoutAction(_ sender: Any) {
        
        //2.7 seconds
        UIView.animate(withDuration: 2.7) {
            self.targetView.alpha = 0
        }
        
    }
    
    //shows a view with animation (alpha from 0 to 1)
    @IBAction func fadeInAction(_ sender: Any) {
        UIView.animate(withDuration: 2.7) {
            self.targetView.alpha = 1
        }

    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        //#function current function
//        print(#file)
//        print(#line)
        print(#function)
    }
    
    @IBAction func toggleUserInteraction(_ sender: UISwitch) {
        greenView.isUserInteractionEnabled = sender.isOn
    }
}

