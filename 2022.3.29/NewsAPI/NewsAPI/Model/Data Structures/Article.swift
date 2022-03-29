//
//  Article.swift
//  NewsAPI
//
//  Created by Benny Davidovitz on 08/03/2022.
//

import Foundation
/*
 {
             "source": {
                 "id": "associated-press",
                 "name": "Associated Press"
             },
             "author": "Steve Karnowski",
             "title": "Minneapolis teachers go on strike after contract talks fail - The Associated Press - en Español",
             "description": "MINNEAPOLIS (AP) — Teachers in the Minneapolis School District walked off the job on Tuesday in a dispute over wages, class sizes and mental health support for students coping with two years of the coronavirus pandemic, at least temporarily pausing classes fo…",
             "url": "https://apnews.com/article/covid-health-business-minneapolis-mental-health-c4e1c35fc92188e3f849eb5847d68d3b",
             "urlToImage": "https://storage.googleapis.com/afs-prod/media/e06467a82e424d859eb509c1064fcc69/3000.jpeg",
             "publishedAt": "2022-03-08T16:18:45Z",
             "content": "MINNEAPOLIS (AP) Teachers in the Minneapolis School District walked off the job on Tuesday in a dispute over wages, class sizes and mental health support for students coping with two years of the cor… [+5133 chars]"
         }
 */

struct Article: Codable {
    
    struct Source: Codable {
        let id: String?
        let name: String?
    }
    
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: URL?
    let urlToImage: URL?
    let publishedAt: String?
    let content: String?
}
