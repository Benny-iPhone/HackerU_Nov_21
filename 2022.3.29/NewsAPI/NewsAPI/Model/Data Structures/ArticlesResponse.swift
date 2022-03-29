//
//  ArticlesResponse.swift
//  NewsAPI
//
//  Created by Benny Davidovitz on 08/03/2022.
//

import Foundation
/*
 {
     "status": "ok",
     "totalResults": 38,
     "articles": [
 */
struct ArticlesResponse: Codable {
    let status: String
    //will hold value on good response
    let totalResults: Int?
    let articles: [Article]?
    //will hold value on bad response
    let message: String?
    let code: String?
}
