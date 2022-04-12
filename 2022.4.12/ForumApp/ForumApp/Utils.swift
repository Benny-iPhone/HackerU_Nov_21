//
//  Utils.swift
//  ForumApp
//
//  Created by Benny Davidovitz on 12/04/2022.
//

import Foundation

extension Date {
    
    var uiString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
    
    var hhmmString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
}
