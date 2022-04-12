//
//  ChatViewController.swift
//  ForumApp
//
//  Created by Benny Davidovitz on 12/04/2022.
//

import UIKit
import FirebaseDatabase


class ChatViewController: UIViewController {

    var room: Room!
    private var refId: DatabaseHandle?
    var tableArray: [ChatMessage] = []
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = room.name
        tableView.dataSource = self
        tableView.delegate = self
        
        listenToDatabase()
        
    }
    
    deinit {
        if let refId = self.refId {
            Room.dbRef.removeObserver(withHandle: refId)
        }
    }
    
    func listenToDatabase() {
        self.refId = ChatMessage.dbRef.child(room.id).observe(DataEventType.value) { [weak self] snapshot in
            guard let self = self else { return }
            guard let roomsDictionary = snapshot.value as? [String:Any] else { return }
            //convert roomsDictionary to array of Room object
            var messages = roomsDictionary.compactMap{ keyPair in
                ChatMessage(id: keyPair.key, value: keyPair.value)
            }
            
            //sort by creation date
            messages.sort {
                $0.createdAt.timeIntervalSince1970 > $1.createdAt.timeIntervalSince1970
            }
            
            self.tableArray = messages
            self.tableView.reloadData()
        }
        
        
    }
    
    
    private func createChatMessage(with text: String) {
        let chatMessage = ChatMessage(text: text)
        chatMessage.saveToDatabase(with: self.room.id)
    }
    
    @IBAction func sendAction(_ sender: UITextField) {
        if let text = sender.text, !text.isEmpty {
            createChatMessage(with: text)
        }
        sender.text = ""
        sender.resignFirstResponder()
    }
    

}


extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        
        let message = tableArray[indexPath.row]
        cell.textLabel?.text = message.text
        cell.detailTextLabel?.text = message.createdByName + " @ " + message.createdAt.uiString
        
        return cell
    }
       
    
}
