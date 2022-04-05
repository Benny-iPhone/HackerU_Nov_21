//
//  Networking.swift
//  OMDBApi
//
//  Created by Benny Davidovitz on 05/04/2022.
//

import Foundation
import Alamofire

class Networking {
    
    static let shared = Networking()
    
    private var apiKey: String {
        "1199eed8"
    }
    
    private var baseUrl: String {
        "http://www.omdbapi.com/" //s=lord of&apikey=
    }
    
    func search(term: String, callback: @escaping (Result<[SearchResult],Error>)->Void) {
        let params: [String:Any] = [
            "s":term,
            "apikey":self.apiKey
        ]
        
        let request = AF.request(baseUrl, parameters: params)
        request.responseDecodable(of: SearchResponse.self) { response in
            if let error = response.error {
                callback(.failure(error))
            } else if let value = response.value {
                callback(.success(value.search ?? []))
            }
        }
        
        //request.cancel()
    }
    
}
