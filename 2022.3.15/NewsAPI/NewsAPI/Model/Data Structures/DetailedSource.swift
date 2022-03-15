//
//  DetailedSource.swift
//  NewsAPI
//
//  Created by Benny Davidovitz on 15/03/2022.
//

import Foundation

/*
 {
 "id": "abc-news",
 "name": "ABC News",
 "description": "Your trusted source for breaking news, analysis, exclusive interviews, headlines, and videos at ABCNews.com.",
 "url": "https://abcnews.go.com",
 "category": "general",
 "language": "en",
 "country": "us"
 }
 */

struct DetailedSource: Codable {
    let id: String
    let name: String
    let description: String?
    let url: URL?
    let category: String? //possible values: business, entertainment, general, health, science, sports, technology
    let language: String?
    let country: String?
}
