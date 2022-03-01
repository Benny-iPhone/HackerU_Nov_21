//
//  MapViewController.swift
//  MockCities
//
//  Created by Benny Davidovitz on 01/03/2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var mapArray: [City] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapArray = City.readCities()
        
        mapView.addAnnotations(mapArray)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
