//
//  DrawView.swift
//  DrawSomethingApp
//
//  Created by Benny Davidovitz on 25/01/2022.
//

import UIKit

class DrawView: UIView {

    var bezierPath = UIBezierPath()
    
    func cleanup() {
        //by creating new, we deleted the old
        bezierPath = UIBezierPath()
        //refresh draw
        self.setNeedsDisplay()
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        bezierPath.stroke()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let p = touches.first?.location(in: self) else { return }
        bezierPath.move(to: p)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        guard let p = touches.first?.location(in: self) else { return }
        bezierPath.addLine(to: p)
        //refresh draw
        self.setNeedsDisplay()
    }
    /*
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    */
    

}
