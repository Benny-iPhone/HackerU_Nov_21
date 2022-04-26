//
//  Utils.swift
//  LocalNotificationProject
//
//  Created by Benny Davidovitz on 26/04/2022.
//

import Foundation

// http://stackoverflow.com/a/40089462

extension Data {
    func hexEncodedString() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}
