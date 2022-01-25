//
//  RotationViewController.swift
//  Gestures
//
//  Created by Benny Davidovitz on 25/01/2022.
//

import UIKit

class RotationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func rotationAction(_ sender: UIRotationGestureRecognizer) {
        //target.view declared as optional UIView, so we guard it
        guard let targetView = sender.view else {
            return
        }
        
        //modify only when gesture started of changed
        guard sender.state == .began || sender.state == .changed else {
            return
        }
        //https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures/handling_rotation_gestures
        //change transforamtion by changed rotation
        targetView.transform = targetView.transform.rotated(by: sender.rotation)
        //reset getsture rotation
        sender.rotation = 0
        
        //targetView.transform = CGAffineTransform(rotationAngle: sender.rotation)
    }
    
}
