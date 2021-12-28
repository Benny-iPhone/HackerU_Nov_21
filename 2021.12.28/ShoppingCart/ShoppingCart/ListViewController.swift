//
//  ListViewController.swift
//  ShoppingCart
//
//  Created by Benny Davidovitz on 28/12/2021.
//

import Foundation
import UIKit

//In this file we will manage the list presentation
// - receive an array of Item
// - display each Item
// - Edit/Delete operation on Item

class ListViewController: UIViewController {
    
    //reference to UI
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //I (ListViewController instance) am your data source, use me to load the UI
        tableView.dataSource = self
    }
    
    //on every apprearence (like back from adding) - reload the UI
    override func viewWillAppear(_ animated: Bool) {
        //just call super-class implementation
        super.viewWillAppear(animated)
        //refresh list
        tableView.reloadData()
    }
}

//UITableViewDataSource is a protocol
//implementing the protocol functions determine what the table-view displays
extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //number of rows is the count of elements in the list
        return ListManager.shared.list.count
    }
    
    //return the row UI Elements (object of type UITableViewCell, or its subclass)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create or reuse ui element
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //indexPath.row - index of the row we are trying to load
        let item = ListManager.shared.list[indexPath.row]
        cell.textLabel?.text = item.name
        
        return cell
    }
    
    
}
















