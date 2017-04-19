//
//  messagesViewController.swift
//  Pair
//
//  Created by Chatan Konda on 4/17/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

enum Section: Int {
    case createNewMessageSection = 0//for saving data to firebase
    case currentChannelSection//listen for new data to save to firebase
}


class messagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var senderDisplayName: String?
  //  var newMessageTextField: UITextField?
    
    
    var ref: FIRDatabaseReference!
    
    private lazy var messageRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Messages")
    private var messageRefHandle: FIRDatabaseHandle?
    
    


    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "RW RIC"
        observeMessages()
        ref = FIRDatabase.database().reference()
        
     
        self.tableView.reloadData()
        
    }
    
    deinit {
        if let refhandle = messageRefHandle{
            messageRef.removeObserver(withHandle: refhandle)
        }
    }
    
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessagesTableViewCell
        
        let message = messageData[indexPath.row]
        
        cell.fromID.text = message.fromID
        cell.timeStamp.text = String(describing: message.timestamp)
        
       
        return cell
    }
    
    @IBAction func cancelView(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageData.count
    }
    
     var messageData = [Message]()
    

    
    
    private func observeMessages(){

        
        
        tableView.delegate = self
        tableView.dataSource = self
        ref = FIRDatabase.database().reference().child("Messages");
        ref.observe(FIRDataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.messageData.removeAll()
                for messages in snapshot.children.allObjects as![FIRDataSnapshot]{
                    //create object and initialize the values of it
                    let message = messages.value as? [String: AnyObject]
                    let fromID = message?["fromID"] as! String?//job type
                    let text = message?["text"] as! String?//job price
                    let timestamp = message?["timestamp"] as! String?// username
                    let toID = message?["toID"] as! String?// job description
                    let messageID = message?["messageID"] as! String?
                    
                    let messageObject = Message(fromID: fromID, text: text, timestamp: timestamp, toID: toID, messageID: messageID)
                    //append data
                    // self.jobData.append(jobObject)
                    
                    self.messageData.insert(messageObject, at: 0)
                }
                self.tableView.reloadData()
                
                //self.animateTable()//animate in progress
                
            }
        })


        
    }
    
    
    
    
    
    


}
