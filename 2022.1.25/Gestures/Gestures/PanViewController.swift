//
//  PanViewController.swift
//  Gestures
//
//  Created by Benny Davidovitz on 25/01/2022.
//

import UIKit

class PanViewController: UIViewController {

    @IBOutlet weak var centerXLayout: NSLayoutConstraint!
    @IBOutlet weak var centerYLayout: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //drag the UI element according to pan (drag) position, using .center attribute
    @IBAction func panAction(_ sender: UIPanGestureRecognizer) {
        //sender.location(in: self.view) - location of drag
        //sender.view?.center <= location of drag
        sender.view?.center = sender.location(in: self.view)
    }
    
    //drag the UI element according to pan (drag) position, using layout system
    //note: implemenation may vary according to the layout constrains
    @IBAction func panActionLayout(_ sender: UIPanGestureRecognizer) {
        let p = sender.location(in: self.view)
        centerXLayout.constant = p.x
        centerYLayout.constant = p.y
    }
    
    //respond to long press gesture,
    //note: IBAction will be invoked also after long press started - when user moves the finger
    //therefore, pay attention to the gesture state
    @IBAction func longPressAction(_ sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            print("began")
            sender.view?.backgroundColor = .blue
        case .changed:
            print("changed")
            sender.view?.center = sender.location(in: self.view)
        case .ended, .cancelled:
            print("finished")
            sender.view?.backgroundColor = .white
            UIView.animate(withDuration: 0.5) {
                sender.view?.frame.origin = CGPoint(x: 286, y: 147)
            }
        default:
            break
        }
        
    }
}
