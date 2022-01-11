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
    
    //invoked when storyboard starts a transition between view controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //sender - the object that triggered the operation
        //for add new -> its the + button (let cell = sender as? UITableViewCell => nil)
        //for edit -> its the cell (row) (let cell = sender as? UITableViewCell => an object)
        
        if let addItemVC = segue.destination as? AddItemViewController,
           let cell = sender as? UITableViewCell {
            //user wants to edit an item
            
            //get the cell's index
            //ask table-view, what is the index for that cell
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            //pass the item to addItemVC
            addItemVC.editItem = ListManager.shared.list[indexPath.row]
        }
        
        if let checkoutVC = segue.destination as? CheckoutViewController {
            //the proper place to calculate the amount is List Manager
            //for each Item we get its total amount
            //then, sum all those amounts
            checkoutVC.total = ListManager.shared.total
        }
    }
}

//UITableViewDataSource is a protocol
//implementing the protocol functions determine what the table-view displays
extension ListViewController: UITableViewDataSource {
    
    //function name - tableView:numberOfRowsInSection:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //number of rows is the count of elements in the list
        return ListManager.shared.list.count
    }
    
    //function name - tableView:cellForRowAt:
    //return the row UI Elements (object of type UITableViewCell, or its subclass)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create or reuse ui element
        //as! => force casting from UITableViewCell to its subclass ItemCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemCell
        
        //populate the cell according to the item content
        let item = ListManager.shared.list[indexPath.row]
        cell.populate(with: item)
        
        //cell is ready, return it
        return cell
        /*
        //create or reuse ui element
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //indexPath.row - index of the row we are trying to load
        let item = ListManager.shared.list[indexPath.row]
        cell.textLabel?.text = item.name
        
        return cell
         */
    }
    
    //function name - tableView:canEditRowAt:
    //function name may vary my argument label
    
    //start typing canEditRowAt and autocomplete will help you
    //purpose: is a row editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true //all rows are editable
    }
    
    //start typing commit and autocomplete will help you
    //purpose: is a row editable
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //delete object from List Manager
            ListManager.shared.delete(at: indexPath.row)
            //delete row from UI
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    
}















