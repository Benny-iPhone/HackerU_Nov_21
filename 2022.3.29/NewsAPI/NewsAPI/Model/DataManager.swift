//
//  DataManager.swift
//  NewsAPI
//
//  Created by Benny Davidovitz on 15/03/2022.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    //allSource is Dictionary, to provide faster access to specific DetailsSource, using its id
    private var allSources: [String:DetailedSource] = [:]
    
    func getSourceBy(id: String) -> DetailedSource? {
        return allSources[id]
    }
    
    func fetchSources() {
        //cleanup
        self.allSources = [:]
        
        //weakify is not needed here
        //retain cycle is okay, since DataManager is static instance
        //still, its good practice
        Networking.shared.getTopHeadlinesSources { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error)
            case .success(let sources):
                for item in sources {
                    self.allSources[item.id] = item
                }
                
                //also can be done using reduce
//                sources.reduce([String:DetailedSource]()) { partialResult, item in
//                    partialResult[item.id] = item
//                }

                //we can refere the argument as $0 for partialResult and $1 for item
//                sources.reduce([String:DetailedSource]()) {
//                    $0[$1.id] = $1
//                }

                
            }
        }
    }
    
}
