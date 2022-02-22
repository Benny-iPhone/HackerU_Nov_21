//
//  ViewController.swift
//  CheckboxProject
//
//  Created by Benny Davidovitz on 22/02/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var checkboxImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //check/uncheck on each tap
    @IBAction func checkboxTapped(_ sender: UITapGestureRecognizer) {
        //you can refer the imageview directly
        //checkboxImageView.isHighlighted = !checkboxImageView.isHighlighted
        //checkboxImageView.isHighlighted.toggle()
        
        //or retreive the image-view from the gesture
        if let imageView = sender.view as? UIImageView {
            imageView.isHighlighted.toggle()
        }
    }
    
}

