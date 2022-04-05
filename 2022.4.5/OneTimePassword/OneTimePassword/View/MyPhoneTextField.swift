//
//  MyPhoneTextField.swift
//  OneTimePassword
//
//  Created by Benny Davidovitz on 05/04/2022.
//

import Foundation
import PhoneNumberKit

class MyPhoneTextField: PhoneNumberTextField {
    
    override var defaultRegion: String {
        get {
            return "IL"
        }
        set {} // exists for backward compatibility
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.withFlag = true
    }
}
