//
//  SecondViewController.swift
//  Drawing
//
//  Created by Benny Davidovitz on 25/01/2022.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var circleView: CircleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        circleView.borderWidth = CGFloat(sender.value)
    }
    
}
