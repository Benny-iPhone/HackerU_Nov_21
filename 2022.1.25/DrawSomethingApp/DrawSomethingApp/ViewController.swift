//
//  ViewController.swift
//  DrawSomethingApp
//
//  Created by Benny Davidovitz on 25/01/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var drawView: DrawView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func trashAction(_ sender: Any) {
        drawView.cleanup()
    }
    
}

