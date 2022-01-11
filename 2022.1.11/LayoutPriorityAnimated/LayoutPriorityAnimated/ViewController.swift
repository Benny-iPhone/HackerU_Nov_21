//
//  ViewController.swift
//  LayoutPriorityAnimated
//
//  Created by Benny Davidovitz on 11/01/2022.
//

import UIKit

class ViewController: UIViewController {

    var collapsed = true
    @IBOutlet weak var expandedLayout: NSLayoutConstraint!
    @IBOutlet weak var collapedLayout: NSLayoutConstraint!
    @IBOutlet weak var cardview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cardview.layer.cornerRadius = 16
    }

    @IBAction func tapAction(_ sender: Any) {
        print("card view tapped")
        if collapsed {
            //expand
            //make expandedLayout stronger
            expandedLayout.priority = .defaultHigh
            collapedLayout.priority = .defaultLow
        } else {
            //collapse
            //make collapedLayout stronger
            collapedLayout.priority = .defaultHigh
            expandedLayout.priority = .defaultLow
        }
        //toggle - turn false to and true to false
        //self.collapsed = !self.collapsed
        self.collapsed.toggle()
        
        //duration is in seconds - 0.7 => 700ms
        //code inside {} will be animated is possible
        //we can animate: element position and size, background color, alpha (opacity)
        UIView.animate(withDuration: 0.7) {
            //trigger layout update
            self.view.layoutSubviews()
        }
    }
    
}

