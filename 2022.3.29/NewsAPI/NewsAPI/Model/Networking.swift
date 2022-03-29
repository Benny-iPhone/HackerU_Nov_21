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
    
    enum NetworkingError: Error, LocalizedError {
        case alamofire(error: Error)
        case backend(code: String?, message: String?)
        
        var errorDescription: String? {
            switch self {
            case .alamofire(_):
                return "Network Error"
            case .backend(_, _):
                return "Backend Error"
            }
        }
    }
    
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
    
    typealias ArticlesCallback = (Result<[Article],NetworkingError>)->Void
    
    func getEverything(with query: String,
                       pageSize: Int = 10,
                       page: Int = 1,
                       callback: @escaping ArticlesCallback) {
        let urlString = baseUrl + Endpoint.everything.rawValue
        let params: [String:Any] = [
            "q":query,
            "pageSize":pageSize,
            "page":page,
            "apiKey":self.apiKey
        ]
        
        self.fireArticlesRequest(with: urlString, params: params, callback: callback)
    }
    
    func getTopHeadlines(with country: String = "de",
                         pageSize: Int = 10,
                         page: Int = 1,
                         callback: @escaping ArticlesCallback) {
        let urlString = baseUrl + Endpoint.topHeadlines.rawValue
        let params: [String:Any] = [
            "country":country,
            "pageSize":pageSize,
            "page":page,
            "apiKey":self.apiKey
        ]
        
        self.fireArticlesRequest(with: urlString, params: params, callback: callback)
    }
    
    private func fireArticlesRequest(with urlString: String, params: [String:Any], callback: @escaping ArticlesCallback) {
        AF.request(urlString, parameters: params).responseDecodable(of: ArticlesResponse.self) { response in
            if let error = response.error {
                callback(.failure(.alamofire(error: error)))
            } else if let articlesResponse = response.value {
                if let articles = articlesResponse.articles {
                    //good response
                    callback(.success(articles))
                } else {
                    //error reponse
                    callback(.failure(.backend(code: articlesResponse.code, message: articlesResponse.message)))
                }
            }
        }
    }
    
    
    
    func getTopHeadlinesSources(callback: @escaping (Result<[DetailedSource],NetworkingError>)->Void) {
        
        let urlString = baseUrl + Endpoint.sources.rawValue
        let params: [String:Any] = [
            "apiKey":self.apiKey
        ]
        
        AF.request(urlString, parameters: params).responseDecodable(of: DetailedSourcesResponse.self) { response in
            if let error = response.error {
                callback(.failure(.alamofire(error: error)))
            } else if let articlesResponse = response.value {
                if let sources = articlesResponse.sources {
                    //good response
                    callback(.success(sources))
                } else {
                    //error reponse
                    callback(.failure(.backend(code: articlesResponse.code, message: articlesResponse.message)))
                }
            }
        }
        
    }
    
}
