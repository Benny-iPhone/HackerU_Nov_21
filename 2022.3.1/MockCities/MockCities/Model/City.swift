//
//  City.swift
//  MockCities
//
//  Created by Benny Davidovitz on 01/03/2022.
//

import Foundation
import MapKit

//can be mapped from and to JSON
//City inherits from NSObject, and declard Codable and MKAnnotation protocols
class City: NSObject, Codable{
    let id: String
    let name: String
    let latitude: Double
    let longitude: Double
    let imageUrl: String
    
    static func readCities() -> [City] {
        //get file url
        guard let url = Bundle.main.url(forResource: "MOCK_DATA", withExtension: "json") else {
            return []
        }
        
        //load json data
        guard let data = try? Data(contentsOf: url) else {
            return []
        }
        
        //parse cities
        guard let cities = try? JSONDecoder().decode([City].self, from: data) else {
            return []
        }
        
        return cities
    }
}

extension City: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    
    var title: String? {
        return name
    }
}
