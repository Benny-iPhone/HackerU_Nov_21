//
//  JSQChatViewController.swift
//  ForumApp
//
//  Created by Benny Davidovitz on 12/04/2022.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import JSQMessagesViewController

class JSQChatViewController: JSQMessagesViewController {

    var room: Room!
    private var refId: DatabaseHandle?
    var tableArray: [JSQMessage] = []
    
    private var incomingBubble: JSQMessagesBubbleImage?
    private var outgoingBubble: JSQMessagesBubbleImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        
        navigationItem.title = room.name
        self.senderId = Auth.auth().currentUser?.uid
        self.senderDisplayName = Auth.auth().currentUser?.displayName
        
        listenToDatabase()
        
        let factory = JSQMessagesBubbleImageFactory()
        incomingBubble = factory?.incomingMessagesBubbleImage(with: .systemBlue)
        outgoingBubble = factory?.outgoingMessagesBubbleImage(with: .systemRed)
        
        //hide avatar placeholder
        collectionView.collectionViewLayout.incomingAvatarViewSize = .zero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = .zero
        
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
            
            self.tableArray = messages.compactMap{
                JSQMessage(senderId: $0.createdBy, senderDisplayName: $0.createdByName, date: $0.createdAt, text: $0.text)
            }
            self.collectionView.reloadData()
        }
        
        
    }
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        createChatMessage(with: text)
    }
    
    
    private func createChatMessage(with text: String) {
        let chatMessage = ChatMessage(text: text)
        chatMessage.saveToDatabase(with: self.room.id)
    }
    
//JSQMessagesCollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return tableArray[indexPath.item]
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        if tableArray[indexPath.item].senderId == senderId {
            return outgoingBubble
        } else {
            return incomingBubble
        }
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        let dateString = tableArray[indexPath.item].date?.hhmmString ?? ""
        return NSAttributedString(string: dateString)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForCellTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        let dateString = tableArray[indexPath.item].date?.hhmmString ?? ""
        return NSAttributedString(string: dateString)
    }
    
    
}
