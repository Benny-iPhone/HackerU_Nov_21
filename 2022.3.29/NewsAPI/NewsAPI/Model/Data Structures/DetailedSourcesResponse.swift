//
//  DetailedSourcesResponse.swift
//  NewsAPI
//
//  Created by Benny Davidovitz on 15/03/2022.
//

import Foundation

//if you think that this type can be merged with ArticlesResponse, you are correct.
//this can be done using "Generics" read about it, implement it, and share the result with all the class.
struct DetailedSourcesResponse: Codable {
    let status: String
    //will hold value on good response
    let sources: [DetailedSource]?
    
    //will hold value on bad response
    let message: String?
    let code: String?
}
