//
//  PinchViewController.swift
//  Gestures
//
//  Created by Benny Davidovitz on 25/01/2022.
//

import UIKit

class PinchViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //by default isUserInteractionEnabled for UILabel/UIImageView is false
        //so, in order for the gesture to be opeation, we have to enable interaction
        imageView.isUserInteractionEnabled = true
    }
    
    @IBAction func pinchAction(_ sender: UIPinchGestureRecognizer) {
        //target.view declared as optional UIView, so we guard it
        guard let targetView = sender.view else {
            return
        }
        
        //we want to restore to default when gesture ended
        switch sender.state {
        case .began, .changed:
            //modify the view transformation (by default - identity) to scale according to the pinch gesture scale
            //old code - caused ui issues
            //targetView.transform = .init(scaleX: sender.scale, y: sender.scale)
            
            //new code - modify by change, reset scale when done
            //https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures/handling_pinch_gestures
            let newTransform = targetView.transform.scaledBy(x: sender.scale, y: sender.scale)
            targetView.transform = newTransform
            sender.scale = 1
        case .cancelled, .ended:
            //getured finished, back to default
            UIView.animate(withDuration: 0.7) {
                targetView.transform = .identity
            }
            
        default:
            break
        }
        
        
        
    }
    

}
