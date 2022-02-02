//
//  AppLabel.swift
//  HelloLabel
//
//  Created by Benny Davidovitz on 01/02/2022.
//

import UIKit

class AppLabel: UILabel {
    
    //init used by storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    //init used from our code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    private func setup() {
        self.textColor = .systemBlue
        //system font
        //self.font = UIFont.systemFont(ofSize: 24)
        //self.font = UIFont.boldSystemFont(ofSize: 32)
        //all font names are listed here
        //https://gist.github.com/steakknife/6de319009539e71603bb
        self.font = UIFont(name: "Bradley Hand", size: 24)
        //0 - unlimited
        self.numberOfLines = 0
        self.lineBreakMode = .byTruncatingHead
        
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
    }

}
