//
//  GradientView.swift
//  GradientBackground
//
//  Created by Benny Davidovitz on 18/01/2022.
//

import UIKit

class GradientView: UIView {

    var colors: [UIColor] = [] {
        didSet {
            setup()
        }
    }
    //keep a reference to the gradient layer
    private weak var gradientLayer: CAGradientLayer!
    
    //In order to support both creation from code - init(frame)
    //and , creation from storyboard too - init(coder)
    //we will override both init methods
    //and call setup in both
    override init(frame: CGRect) {
        //do what you have to do on init
        super.init(frame: frame)
        //and setup gradient
        setup()
    }
    
    //required is just like override, but override for an init method that declared in protocol too
    required init?(coder: NSCoder) {
        //do what you have to do on init
        super.init(coder: coder)
        //and setup gradient
        setup()
    }
    
    //setup gradient layer
    private func setup() {
        //clean old layer
        self.gradientLayer?.removeFromSuperlayer()
        
        //create
        
        let gradientLayer = CAGradientLayer()
        //colors of gradientLayer is an array of CGColor
        //GradientView colors is an array of UIColor
        //and so "self.colors.compactMap{ $0.cgColor }" convert [UIColor] to [CGColor]
        gradientLayer.colors = self.colors.compactMap{ $0.cgColor }
        
        //layer as something that need to be displayed requires frame (hopefuly not 0)
        //we want the layer to cover all of self (self is the view)
        gradientLayer.frame = self.bounds
        //start at top left
        gradientLayer.startPoint = CGPoint.zero //0,0
        //end at bottom right
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        self.layer.addSublayer(gradientLayer)
        self.gradientLayer = gradientLayer
    }
    
    //on layoutSubviews command
    override func layoutSubviews() {
        //first, do you thing
        super.layoutSubviews()
        //second, now update the gradient layer frame
        self.gradientLayer.frame = self.bounds
        
    }
    

}
