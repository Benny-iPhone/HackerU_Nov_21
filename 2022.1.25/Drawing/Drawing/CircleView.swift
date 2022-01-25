//
//  CircleView.swift
//  Drawing
//
//  Created by Benny Davidovitz on 25/01/2022.
//

import UIKit

class CircleView: UIView {

    var borderWidth: CGFloat = 1 {
        didSet {
            //refresh draw
            self.setNeedsDisplay()
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        //context is our pencil
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        //context.addEllipse(in: <#T##CGRect#>)
        let w = self.bounds.width
        let h = self.bounds.height
        let radius = min(w, h) * 0.4
        
        //angles are in Radians
        context.addArc(center: CGPoint(x: w * 0.5, y: h * 0.5),
                       radius: radius,
                       startAngle: 0,
                       endAngle: CGFloat.pi * 2,
                       clockwise: false)
        
        context.setLineWidth(max(self.borderWidth,1))
        
        context.strokePath()
        
    }
    

}
