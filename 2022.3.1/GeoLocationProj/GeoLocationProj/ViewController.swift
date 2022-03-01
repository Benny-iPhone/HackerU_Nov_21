//
//  ViewController.swift
//  GeoLocationProj
//
//  Created by Benny Davidovitz on 01/03/2022.
//

import UIKit

class ViewController: UIViewController {

    let manager = LocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //[weak self] - capture self weakly to avoid retain cycle
        
        //Out potential retain cycle:
        //clouse capture self (ViewController)
        //ViewController captures LocationManager
        //LocationManager captures callback
        //callback captures self (ViewController)
        
        //how to break to cycle
        //clouse capture self (ViewController) - WEAKLY
        manager.getLocation { [weak self] result in
            //guard self - if self released, abort
            guard let self = self else { return }
            switch result {
            case .success(let location):
                print(location)
            case .failure(let error):
                self.handle(error: error)
            }
            
        }
        
        //...
        
        var num = 3
        //do something 1 second later
        //a clouse strongly capture the objects that its refering to
        //as long as the clouse (async function) is alive, the objects its pointing to, also alive
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            num += 1
            print(num)
            //self.handle(error: .userDenied)
        }
    }
    
    func handle(error: LocationManager.LocationError) {
        switch error {
        case .userDenied:
            print("open settings")
            //https://stackoverflow.com/questions/37654132/how-to-open-location-services-screen-from-setting-screen
            if let bundleId = Bundle.main.bundleIdentifier,
                let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(bundleId)")
            {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        case .locationService(_):
            print("location server error| TODO: show alert to user")
        }
    }


}

