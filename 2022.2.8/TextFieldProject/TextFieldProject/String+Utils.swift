//
//  String+Utils.swift
//  TextFieldProject
//
//  Created by Benny Davidovitz on 08/02/2022.
//

import Foundation
import libPhoneNumber_iOS

extension String {
    //https://stackoverflow.com/a/56617023/6133419
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    
    //check if string contains 'real' character
    //inspired from: https://stackoverflow.com/questions/27768064/check-if-swift-text-field-contains-non-whitespace
    var isContainsNonWhiteSpaces: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).count > 0
    }
    
    //check if string represents a valid phone number (Default Region: IL)
    var isValidPhoneNumber: Bool {
        //exclude emergency numbers
        guard self.count > 4 else { return false }
        
        //https://github.com/iziz/libPhoneNumber-iOS
        guard let util = NBPhoneNumberUtil.sharedInstance() else { return false }
        guard let number = try? util.parse(self, defaultRegion: "IL") else {
            print("failed to parse " + self)
            return false
        }
        
        return util.isValidNumber(number)
    }
    
}
