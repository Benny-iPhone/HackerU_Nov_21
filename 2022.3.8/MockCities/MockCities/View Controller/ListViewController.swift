//
//  ListViewController.swift
//  MockCities
//
//  Created by Benny Davidovitz on 01/03/2022.
//

import UIKit
import CoreLocation

class ListViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var tableArray: [City] = []
    var userLocation: CLLocation?
    let locationManager = LocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableArray = City.readCities()
        tableView.dataSource = self
        
        //[weak self] - capture self (ListViewController) weakly to avoid memory issues
        locationManager.getLocation { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(_):
                break
            case .success(let location):
                self.userLocation = location
                self.sort(by: location)
                //refresh UI
                self.tableView.reloadData()
            }
        }
    }
    
    private func sort(by location: CLLocation) {
        tableArray.sort { city1, city2 in
            let dist1 = CLLocation(latitude: city1.latitude, longitude: city1.longitude).distance(from: location)
            let dist2 = CLLocation(latitude: city2.latitude, longitude: city2.longitude).distance(from: location)
            
            return dist1 > dist2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let city = tableArray[indexPath.row]
        cell.textLabel?.text = city.name
        if let userLocation = userLocation {
            //we got user location, lets show the distance
            let cityLocation = CLLocation(latitude: city.latitude, longitude: city.longitude)
            let distance = cityLocation.distance(from: userLocation) //meters
            //%f - placeholder for float number
            //%.2f - placeholder for float number, 2 digit after the "." sign
            //for example: 1.00 , 3.14 (14.1234 => 14.12), (14.5163 => 14.52)
            cell.detailTextLabel?.text = String(format: "distance: %.2f km", distance / 1000)
        } else {
            cell.detailTextLabel?.text = ""
        }
        
        return cell
    }

}
