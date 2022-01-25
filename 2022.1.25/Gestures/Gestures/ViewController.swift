//
//  ViewController.swift
//  Gestures
//
//  Created by Benny Davidovitz on 25/01/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var targetView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        print("tapped \(sender.numberOfTapsRequired))")
        sender.view?.backgroundColor = .green
        UIView.animate(withDuration: 1.5) {
            sender.view?.backgroundColor = .black
        }
    }
    
}

