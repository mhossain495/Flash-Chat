//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Mohammed Hossain on 21/09/2020.


import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    // Initialize an instance of Cloud Firestore
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Add title in navigation bar
        title = K.appName
        tableView.dataSource = self
        
        // Hides back button from navigation bar
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
    }
    
    func loadMessages() {
        
        // Load Firestore collection and order messages by date key value
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
                
                // Start with empty messages array instead of prior data
                self.messages = []
                
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    
                    
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let messagesender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                                let newMessage = Message(sender: messagesender, body: messageBody)
                                
                                
                                self.messages.append(newMessage)
                                
                                // Load message data
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    
                                    // Scroll to last message based on array position in section 0 of table
                                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                                    
                                }
                            }
                        }
                    }
                }
            }
    }
    
        
    
    // Save newly sent message to Firestore database messages collection with sender, body, and date fields
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print ("There was an issue saving data to firestore, \(e)")
                } else {
                    print ("Successfully saved data.")
                    
                    // Clear text field after sending message; DispathQueue required in closure to execute code in main thread rather than background thread so that user interface updates
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                   
                }
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
}


extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        // Message cell from xib file
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
            as! MessageCell
        
        cell.label.text = message.body
        
        // Message from current user
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
            
        } // This is a message from another user
        
        else {
            
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
            
        }
        
       
        return cell
    }
    
    
}


