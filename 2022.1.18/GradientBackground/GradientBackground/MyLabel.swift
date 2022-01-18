//
//  MyLabel.swift
//  GradientBackground
//
//  Created by Benny Davidovitz on 18/01/2022.
//

import UIKit

class MyLabel: UILabel {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        //if we will not invoke "super.draw(rect)" then text will not be drawn
        super.draw(rect)
    }
    

}
