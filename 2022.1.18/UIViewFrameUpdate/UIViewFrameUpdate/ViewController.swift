//
//  ViewController.swift
//  UIViewFrameUpdate
//
//  Created by Benny Davidovitz on 18/01/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //1 - have a property, do not forget to set it, just like IBOutlet
    weak var myView: UIView?
    func getViewReferenceByProperty() -> UIView? {
        return myView
    }
    
    //2 filter subviews
    func getViewReferenceBySubview() -> UIView? {
        return self.view.subviews
            .filter{ ($0.backgroundColor?.isEqual(UIColor.systemYellow)) ?? false }
            .first
    }
    
    //3 using tag, set a tag on creation , the use it
    func getViewReferenceByTag() -> UIView? {
        self.view.viewWithTag(10)
    }
    
    @IBAction func createAction(_ sender: Any) {
        //make sure that was not created yet
        guard myView == nil else {
            print("can not create, view already exist")
            return
        }
        
        let aView = UIView(frame: CGRect(x: 0, y: 120, width: 80, height: 80))
        aView.backgroundColor = .systemYellow
        aView.tag = 10
        self.view.addSubview(aView)
        
        //set propery for future reference
        self.myView = aView
    }
    
    
    @IBAction func moveXAction(_ sender: Any) {
        //make sure that myView exist
        guard let myView = self.myView else {
            print("view does not exist")
            return
        }

        var rect = myView.frame
        //do not exceed parent view width
        if rect.origin.x + 50 >= self.view.bounds.width {
            rect.origin.x = 0
        } else {
            rect.origin.x += 50
        }
        //update myView position
        myView.frame = rect
        
        //myView.center.x += 50
    }
    
    @IBAction func moveYAction(_ sender: Any) {
        //make sure that myView exist
        guard let myView = self.myView else {
            print("view does not exist")
            return
        }

        var rect = myView.frame
        //do not exceed view height
        if rect.origin.y + 50 >= self.view.bounds.height {
            rect.origin.y = 0
        } else {
            rect.origin.y += 50
        }
        //update myView position
        myView.frame = rect
    }
    
    @IBAction func removeAction(_ sender: Any) {
        //to remove a view from UI call removeFromSuperview() on that view
        self.myView?.removeFromSuperview()
        
        //myView will be nil after removal because it a weak reference.
    }
    
    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        guard let myView = self.myView else {
            print("view does not exist")
            return
        }
        
        //where did the tapp happended (CGPoint(x,y))
        let point: CGPoint = sender.location(in: self.view)
        //center: CGPoint is the center of the object, relative to it parent
        //center.x <= frame.origin.x + frame.size.width * 0.5
        //center.y <= frame.origin.y + frame.size.height * 0.5
        UIView.animate(withDuration: 0.3) {
            myView.center = point
        }
    }
    
    
}

