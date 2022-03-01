//
//  WazeUtils.swift
//  PlacesApp
//
//  Created by Benny Davidovitz on 01/03/2022.
//

import Foundation
import CoreLocation
import UIKit

class WazeUtils {
    
    class func navigate(to coordinate: CLLocationCoordinate2D) {
        //build waze deep link url
        let urlString = "waze://?ll=\(coordinate.latitude),\(coordinate.longitude)&navigate=yes"
        guard let url = URL(string: urlString) else {
            return
        }
        
        //check if waze installed
        guard UIApplication.shared.canOpenURL(url) else {
            print("waze not installed| TODO: open app store")
            return
        }
        
        //open waze
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}
