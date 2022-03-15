//
//  Networking.swift
//  NewsAPI
//
//  Created by Benny Davidovitz on 08/03/2022.
//

import Foundation
import Alamofire

class Networking {
    
    static let shared = Networking()
    
    enum Endpoint: String {
        case everything = "everything"
        case topHeadlines = "top-headlines"
        case sources = "top-headlines/sources"
    }
    
    private var apiKey: String {
        return "bd10f79c843d4116bb36c91f6333584b"
    }
    
    private var baseUrl: String {
        return "https://newsapi.org/v2/"
    }
    
    func getTopHeadlines(with country: String = "us",
                         pageSize: Int = 10,
                         page: Int = 1,
                         callback: @escaping (Result<[Article],Error>)->Void) {
        
        let urlString = baseUrl + Endpoint.topHeadlines.rawValue
        let params: [String:Any] = [
            "country":country,
            "pageSize":pageSize,
            "page":page,
            "apiKey":self.apiKey
        ]
        
        AF.request(urlString, parameters: params).responseDecodable(of: ArticlesResponse.self) { response in
            if let error = response.error {
                callback(.failure(error))
            } else if let articlesResponse = response.value {
                callback(.success(articlesResponse.articles))
            }
        }
        
    }
    
    func getTopHeadlinesSources(callback: @escaping (Result<[DetailedSource],Error>)->Void) {
        
        let urlString = baseUrl + Endpoint.sources.rawValue
        let params: [String:Any] = [
            "apiKey":self.apiKey
        ]
        
        AF.request(urlString, parameters: params).responseDecodable(of: DetailedSourcesResponse.self) { response in
            if let error = response.error {
                callback(.failure(error))
            } else if let articlesResponse = response.value {
                callback(.success(articlesResponse.sources))
            }
        }
        
    }
    
}
