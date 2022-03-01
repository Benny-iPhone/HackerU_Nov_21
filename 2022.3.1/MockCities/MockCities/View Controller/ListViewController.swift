//
//  ListViewController.swift
//  MockCities
//
//  Created by Benny Davidovitz on 01/03/2022.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var tableArray: [City] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableArray = City.readCities()
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let city = tableArray[indexPath.row]
        cell.textLabel?.text = city.name
        cell.detailTextLabel?.text = "TBD: Fill Distance"
        
        return cell
    }

}
