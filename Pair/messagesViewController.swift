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
import JSQMessagesViewController

enum Section: Int {
    case createNewMessageSection = 0//for saving data to firebase
    case currentChannelSection//listen for new data to save to firebase
}


class messagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var senderDisplayName = AppDelegate.user.username
    
    
    var ref: FIRDatabaseReference!
    
    private lazy var messageRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Messages")
    
    private var messageRefHandle: FIRDatabaseHandle?
    
      var messageData = [Message]()
    
//    func setup() {
//        self.senderId = "1234"
//        self.senderDisplayName = "TEST"
//    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Messages"
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
    
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let message = messageData[(indexPath as NSIndexPath).row]
        self.performSegue(withIdentifier: "gotoMessage", sender: message)
    }
   
    

    
    
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
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
////        
////        print("self sender disp name = \(self.senderDisplayName!)");
////        print(sender)
//        if let message = sender as? MessagesTableViewCell {
//            let chatVC = segue.destination as! chatViewController
//            chatVC.senderDisplayName = AppDelegate.user.username
//            chatVC.senderId = AppDelegate.user.userID
//            
//           // chatVC.message =
//            chatVC.messageRef = messageRef.child(message.messageID!)
//        }else{
//            print("failed")
//            
//        }
//    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "gotoMessage") {
            // initialize new view controller and cast it as your view controller
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let chatVC = segue.destination as? chatViewController
               // chatVC?.message = messageData[indexPath.row].text!
                chatVC?.senderDisplayName = AppDelegate.user.username
                chatVC?.senderId = AppDelegate.user.userID
                chatVC?.selectedText = messageData[indexPath.row].text!
                chatVC?.selectedtimeStamp = messageData[indexPath.row].timestamp!
                chatVC?.selectedMessageID = messageData[indexPath.row].messageID!
                chatVC?.selectedtoID = messageData[indexPath.row].toID!
                chatVC?.selectedfromID = messageData[indexPath.row].fromID!
                
                
//                let messageD = sender as? Message
//                chatVC?.message = messageD
//                chatVC?.messageRef = messageRef.child(messageD.messageID!)
                
            }
        }
    }
    
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if (segue.identifier == "gotoBid") {
//            // initialize new view controller and cast it as your view controller
//            if let indexPath = self.tableView.indexPathForSelectedRow{
//                let postbidView = segue.destination as? postBidViewController
//                
//                postbidView?.selectedName = jobData[indexPath.row].jobName!
//                postbidView?.selectedDescription = jobData[indexPath.row].description!
//                postbidView?.selectedID = jobData[indexPath.row].postid!
//                
//                postbidView?.toID = jobData[indexPath.row].username!
//            }
//        }
//    }
//    
//    
    
    
    
    
    
    
    
    
    
    
    
    
    
   
    
    
    


}
