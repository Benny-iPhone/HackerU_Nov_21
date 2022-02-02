//
//  String+utils.swift
//  LocalizedApp
//
//  Created by Benny Davidovitz on 01/02/2022.
//

import Foundation

extension String {
    
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
}
