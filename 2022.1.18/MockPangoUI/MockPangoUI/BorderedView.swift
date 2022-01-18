//
//  BorderedView.swift
//  MockPangoUI
//
//  Created by Benny Davidovitz on 18/01/2022.
//

import UIKit

class BorderedView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //clear background
        self.backgroundColor = .clear
        
        //setup border - blueish (60% opacity)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.6).cgColor
        
        //setup corner radius - half of the height
        self.layer.cornerRadius = self.bounds.height * 0.5
        
        //setup shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
    }

}
