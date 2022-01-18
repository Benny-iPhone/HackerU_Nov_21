//
//  ViewController.swift
//  HelloUIView
//
//  Created by Benny Davidovitz on 18/01/2022.
//

import UIKit

class ViewController: UIViewController {

    //declare safeBgView in order to reference it later
    private weak var safeBgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let's create a new UIView and add it to our UI
        //CGRect - Core Graphics RECTangle (x, y, width, height)
        //CGRect - origin: CGPoint(x,y), size: CGSize(width, height)
        //all values are CGFloat, which is a Float, but of different type
        let redView = UIView(frame: CGRect(x: 55, y: 158, width: 242, height: 143))
        //redView.backgroundColor = UIColor.systemRed
        redView.backgroundColor = .systemRed
        //view is visible, if its parent is visible
        //add redView to the view-controller's view
        self.view.addSubview(redView)
        
        //add another view, blue background, collide with redView
        //copy the frame of redView, and modify it
        var rect = redView.frame
        rect.origin.x += 30
        rect.origin.y += 100
        
        let blueView = UIView(frame: rect)
        blueView.backgroundColor = .systemBlue
        self.view.addSubview(blueView)
        
        //now blue-view is in top on red-view
        //let's make the red-view on top
        self.view.bringSubviewToFront(redView)
        
        
        //Safe Background View
        let safeBgView = UIView(frame: self.view.bounds)
        safeBgView.backgroundColor = .systemYellow
        self.view.addSubview(safeBgView)
        //keep a reference
        self.safeBgView = safeBgView
        
        //make it first in z index
        self.view.sendSubviewToBack(safeBgView)
        
        //Background View
        
        let bgView = UIView(frame: self.view.bounds)
        bgView.backgroundColor = .systemGray
        self.view.addSubview(bgView)
        
        //make it first in z index
        self.view.sendSubviewToBack(bgView)
        
        /*
         Frame - (x,y,width, height) relative to parent
         Bounds - (x,y,width, height) relative to itself - x,y is 0,0
         
         width and height of frame and bounds, may be different if the view is rotated
         */
        
        print(self.view.subviews)
    }
    
    //update the safe background view according to updated safeAreaInsets
    private func updateSafeBackgroundView() {
        var safeRect = self.view.bounds
        //what is the safe area margin
        //self.view.safeAreaInsets
        safeRect.origin.x += self.view.safeAreaInsets.left
        safeRect.origin.y += self.view.safeAreaInsets.top
        safeRect.size.height -= (self.view.safeAreaInsets.top + self.view.safeAreaInsets.bottom)
        safeRect.size.width -= (self.view.safeAreaInsets.left + self.view.safeAreaInsets.right)
        
        //update safeBgView position and size
        self.safeBgView.frame = safeRect
    }
    
    //view layout updated - lets update the safe background
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateSafeBackgroundView()
    }

}

