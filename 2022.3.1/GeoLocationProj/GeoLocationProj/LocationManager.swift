//
//  LocationManager.swift
//  GeoLocationProj
//
//  Created by Benny Davidovitz on 01/03/2022.
//

import Foundation
import CoreLocation

//inheritance of NSObject is made for easy implementation of CLLocationManagerDelegate protocol which extends NSObjectProtocol

class LocationManager: NSObject {
    
    enum LocationError: Error {
        case userDenied
        case locationService(error: Error)
    }
    
    typealias Callback = (Result<CLLocation,LocationError>)->Void
    
    let clLocationManager: CLLocationManager
    private var callback: Callback?
    
    override init() {
        self.clLocationManager = CLLocationManager()
        super.init()
        
        clLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        //clLocationManager.distanceFilter = 10 //meters
        clLocationManager.delegate = self
    }
    
    func getLocation(with callback: @escaping Callback) {
        //if denied - return | open settings
        if didDenyPermission() {
            callback(.failure(.userDenied))
            self.callback = nil
            return
        }
        
        //store call for future usage
        self.callback = callback
        
        //if permission granted - start location updates
        if didGrantPermission() {
            clLocationManager.startUpdatingLocation()
            return
        }
        //if not determined - ask for permission
        if didNotDeterminePermission() {
            //only when the app is open
            clLocationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func didGrantPermission() -> Bool {
        switch clLocationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        default:
            return false
        }
    }
    
    private func didDenyPermission() -> Bool {
        switch clLocationManager.authorizationStatus {
        case .denied, .restricted:
            return true
        default:
            return false
        }
    }
    
    private func didNotDeterminePermission() -> Bool {
        switch clLocationManager.authorizationStatus {
        case .notDetermined:
            return true
        default:
            return false
        }
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    //😀 we got user location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        //we got the location, we can stop updating now
        manager.stopUpdatingLocation()
        
        //return result to callback
        self.callback?(.success(locations[0]))
        self.callback = nil
    }
    
    //💩 we failed to get user location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.callback?(.failure(.locationService(error: error)))
        self.callback = nil
        print(error)
    }
    
    private func authorizationChanged() {
        //start over, this time, hopefuly with granted permission
        //we only have callback if fetching location is in progress
        if let callback = self.callback {
            getLocation(with: callback)
        }
    }
    
    //new method - Authorization changed
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationChanged()
    }
    
    //old method - Authorization changed
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationChanged()
    }
    
}
