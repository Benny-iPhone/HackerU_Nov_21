//
//  TriangleView.swift
//  Drawing
//
//  Created by Benny Davidovitz on 25/01/2022.
//

import UIKit

class TriangleView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        //context is our pencil
        guard let context = UIGraphicsGetCurrentContext() else { return }
    
        let w = self.bounds.width
        let h = self.bounds.height
        
        //upper point
        context.move(to: CGPoint(x: w * 0.5, y: h * 0.1))
        //draw line to right bottom point
        context.addLine(to: CGPoint(x: w * 0.9, y: h * 0.9))
        //draw line to left bottom point
        context.addLine(to: CGPoint(x: w * 0.1, y: h * 0.9))
        //close shape
        
        context.closePath()

        //change border size
        context.setLineWidth(4)
        
        //change border color
        //context.setStrokeColor(UIColor.red.cgColor)
        UIColor.red.setStroke()
        
        //fill color
        //context.setFillColor(UIColor.green.cgColor)
        UIColor.green.setFill()
        
        //draw border
        //context.strokePath()
        //OR draw fill
        //context.fillPath()
        
        //do both, fill and stroke
        context.drawPath(using: .fillStroke)
    }
    

}
