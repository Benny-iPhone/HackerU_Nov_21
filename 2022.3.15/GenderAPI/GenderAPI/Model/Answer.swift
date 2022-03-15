//
//  Answer.swift
//  GenderAPI
//
//  Created by Benny Davidovitz on 08/03/2022.
//

import Foundation

/*
 {
     "name": "elizabeth",
     "name_sanitized": "Elizabeth",
     "country": "IL",
     "gender": "female",
     "samples": 44,
     "accuracy": 98,
     "duration": "17ms",
     "credits_used": 1
 }
 */

struct Answer: Codable {
    
    enum Gender: String, Codable {
        case male
        case female
        case unknown
        
        var display: String {
            switch self {
            case .male:
                return NSLocalizedString("Male", comment: "")
            case .female:
                return NSLocalizedString("Female", comment: "")
            case .unknown:
                return NSLocalizedString("Unknown", comment: "")
            }
        }
    }
    
    let gender: Gender //Possible values: male, female, unknown
    let accuracy: Int
    let samples: Int
}
