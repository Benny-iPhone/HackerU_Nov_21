//
//  Utils.swift
//  NewsAPI
//
//  Created by Benny Davidovitz on 15/03/2022.
//

import Foundation

extension String {
    //2022-01-30 23:15:00
    func stringToDate_yyyy_MM_dd_T_HH_mm_ssZ() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en")
        //formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.date(from: self)
    }
    
}

extension Date {
    
    //convert Date object to nice string
    //Today 10:45
    //30.1.22 10:45
    func toRelativeString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter.string(from: self)
    }
    
}
