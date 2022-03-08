//
//  Networking.swift
//  GenderAPI
//
//  Created by Benny Davidovitz on 08/03/2022.
//

import Foundation
import Alamofire

class Networking {
    
    static let shared = Networking()
    
    private var apiKey: String {
        return "mvabClVyGwZEaKEpxW"
    }
    
    private var baseUrl: String {
        return "https://gender-api.com/"
    }
    
    func checkGenderAlamofire(by name: String, callback: @escaping (Result<Answer,Error>)->Void) {
        let params: [String:Any] = [
            "name":name,
            "country":"IL",
            "key":self.apiKey
        ]
        
        AF.request(baseUrl + "get", parameters: params).responseDecodable(of: Answer.self) { response in
            if let error = response.error {
                callback(.failure(error))
            } else if let answer = response.value {
                callback(.success(answer))
            }
        }
    }
    
    func checkGender(by name: String, callback: @escaping (Result<Answer,Error>)->Void) {
        let params: [String:Any] = [
            "name":name,
            "country":"IL",
            "key":self.apiKey
        ]
        
        self.sendGetRequest(with: "get", params: params) { result in
            switch result {
            case .failure(let error):
                callback(.failure(error))
            case .success(let data):
                //parse data to Answer
                do {
                    let answer = try JSONDecoder().decode(Answer.self, from: data)
                    callback(.success(answer))
                } catch let serializeError {
                    callback(.failure(serializeError))
                }
            }
        }
    }
    
    //implementation with native api (URLSession, URLRequest)
    private func sendGetRequest(with endpoint: String,
                                params: [String:Any],
                                callback: @escaping (Result<Data,Error>)->Void) {
        
        //compose the request using URLComponents api
        guard var comps = URLComponents(string: baseUrl + endpoint) else { return }
        //for each pair in params we create an URLQueryItem object
        //all of those sumes in to an array, and set to comp.queryItems
        comps.queryItems = params.compactMap{ URLQueryItem(name: $0.key, value: "\($0.value)") }
        
        //get the full url (with query items)
        guard let url = comps.url else { return }
        print(url)
        let request = URLRequest(url: url)
        //you can add more to the request object
//        request.httpMethod = "POST"
//        request.httpBody = postData //object of type Data
//        request.setValue("Content-Type", forHTTPHeaderField: "Application/Json")
        
                
        URLSession.shared.dataTask(with: request) { data, resonse, error in
            //result from URLSession in in background thread
            //So, DispatchQueue.main.async => do job on main thread
            DispatchQueue.main.async {
                if let error = error {
                    callback(.failure(error))
                } else if let data = data {
                    callback(.success(data))
                }
            }
        }.resume()
        //without .resume() the request will not fire
    }
    
}

