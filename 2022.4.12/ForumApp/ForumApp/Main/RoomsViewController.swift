//
//  RoomsViewController.swift
//  ForumApp
//
//  Created by Benny Davidovitz on 12/04/2022.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RoomsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var tableArray: [Room] = []
    private var refId: DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        listenToDatabase()
        
        if let username = Auth.auth().currentUser?.displayName {
            navigationItem.title = "Hello " + username
        }
    }
    
    deinit {
        if let refId = self.refId {
            Room.dbRef.removeObserver(withHandle: refId)
        }
    }
    
    func listenToDatabase() {
        self.refId = Room.dbRef.observe(DataEventType.value) { [weak self] snapshot in
            print("received value event")
            guard let self = self else { return }
            guard let roomsDictionary = snapshot.value as? [String:Any] else { return }
            //convert roomsDictionary to array of Room object
            var rooms = roomsDictionary.compactMap{ keyPair in
                Room(id: keyPair.key, value: keyPair.value)
            }
            
            //sort by creation date
            rooms.sort { r1, r2 in
                return r1.createdAt.timeIntervalSince1970 < r2.createdAt.timeIntervalSince1970
            }
            
            self.tableArray = rooms
            self.tableView.reloadData()
        }
        
        
    }
    
    private func createRoom(with name: String) {
        print("room name: " + name)
        let room = Room(name: name)
        room.saveToDatabase()
    }
    
    @IBAction func signOutAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            FlowManager.shared.determineFlow()
        } catch {
            print(error)
        }
    }
    
    
    @IBAction func addRoomAction(_ sender: Any) {
        let alertView = UIAlertController(title: "Create a room", message: nil, preferredStyle: .alert)
        
        alertView.addTextField { textField in
            textField.placeholder = "Room Name"
        }
        
        //Create Button + handler
        alertView.addAction(UIAlertAction(title: "Create", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            //get the input by textFields property of the alertview, no need to retain a propery in the view-controller like some suggestion over the internet
            guard let name = alertView.textFields?.first?.text, !name.isEmpty else { return }
            
            self.createRoom(with: name)
        }))
        
        //Cancel Button
        alertView.addAction(UIAlertAction(title: "Discard", style: .destructive, handler: nil))
        
        //Show Alert
        
        self.present(alertView, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let chatVC = segue.destination as? JSQChatViewController,
           let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            //destination is ChatViewController, and we know the index of the selected cell
            let room = tableArray[indexPath.row]
            chatVC.room = room
        }
    }
    
}

extension RoomsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let room = tableArray[indexPath.row]
        cell.textLabel?.text = room.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //support delete
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let room = tableArray[indexPath.row]
        let uid = Auth.auth().currentUser?.uid ?? ""
        return room.createdBy == uid
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let room = tableArray[indexPath.row]
        room.removeFromDatabase()
    }
    
}
