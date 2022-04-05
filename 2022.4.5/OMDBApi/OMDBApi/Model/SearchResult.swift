//
//  SearchResult.swift
//  OMDBApi
//
//  Created by Benny Davidovitz on 05/04/2022.
//

import Foundation
/*
 {
             "Title": "The Lord of the Rings: The Fellowship of the Ring",
             "Year": "2001",
             "imdbID": "tt0120737",
             "Type": "movie",
             "Poster": "https://m.media-amazon.com/images/M/MV5BN2EyZjM3NzUtNWUzMi00MTgxLWI0NTctMzY4M2VlOTdjZWRiXkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_SX300.jpg"
         },
 */
struct SearchResult: Codable {
    enum ItemType: String, Codable {
        case movie, series, episode, game
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
    
    let title: String
    let year: String
    let imdbID: String
    let type: ItemType?
    let poster: URL?
}

struct SearchResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
        case error = "Error"
    }
    
    let search: [SearchResult]?
    let totalResults: String?
    let response: String
    let error: String?
}
