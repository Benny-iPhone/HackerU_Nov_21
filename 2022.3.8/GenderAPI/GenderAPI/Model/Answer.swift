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
    let gender: String //Possible values: male, female, unknown
    let accuracy: Int
    let samples: Int
}
