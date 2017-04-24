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
import SwiftyJSON


enum Section: Int {
    case createNewMessageSection = 0//for saving data to firebase
    case currentChannelSection//listen for new data to save to firebase
}




class messagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var senderDisplayName = AppDelegate.user.username
    @IBOutlet weak var tableView: UITableView!
    var ref: FIRDatabaseReference!
    
    private lazy var messageRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Messages")
    

    
    private var messageRefHandle: FIRDatabaseHandle?
    
    
   // let json = JSON(data: <#T##Data#>)
    
    var messageData = [Message]()
    
//    func setup() {
//        self.senderId = "1234"
//        self.senderDisplayName = "TEST"
//    }

    
    
    //     cell.senderName.text = message.name
    //cell.timeStamp.text = String(describing: message.timestamp!)
    var messagesDictionary = [String: Message]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var ref: FIRDatabaseReference!
        
        tableView.delegate = self
        tableView.dataSource = self

        
        title = "Messages"
        //observeMessages()
        tableView.delegate = self
        tableView.dataSource = self
        //ref = FIRDatabase.database().reference().child("Messages").child("-KiCP4P4Gw8uw_3QWvGj");
        ref = FIRDatabase.database().reference().child("Messages");
        ref.observe(FIRDataEventType.value, with: {(snapshot)
            in
            if snapshot.childrenCount>0{
                // for jobs in snapshot.children.allObjects as![FIRDataSnapshot]{
                
                self.messageData.removeAll()
                
                for messages in snapshot.children.allObjects as! [FIRDataSnapshot]{
                    
                    let message =  messages.value as? [String: AnyObject]
                    
                    let fromID = message?["destinationID"];
                    let toID = message?["fromID"];
                    let text = message?["text"];
                    let timestamp = message?["timestamp"];
                    
                    let newMessageData = Message(fromID: toID as? String, text: text as? String, timestamp: timestamp as? String, destinationID: fromID as? String)
                    if let toID = newMessageData.fromID{
                        self.messagesDictionary[toID] = newMessageData
                        self.messageData = Array(self.messagesDictionary.values)
                    }
                    
                    //self.messageData.insert(newMessageData, at: 0)
                    print("messageData size = \(self.messageData.count)")
                }
                
            }
            print("size of mmessage data = \(self.messageData.count)")
            self.tableView.reloadData()
            //self.animateTable()//animate in progress
        })

       print("finished observing")
        ref = FIRDatabase.database().reference()

        //print("size of mmessage data = \(messageData.count)")
        
        //self.tableView.reloadData()
        
    }
    
    deinit {
        if let refhandle = messageRefHandle{
            messageRef.removeObserver(withHandle: refhandle)
        }
    }
    
    
    
    
    
    //var chatrooms = NSDictionary
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessagesTableViewCell
        
        let message = messageData[indexPath.row]
        
        let loggedInUser = FIRAuth.auth()?.currentUser?.uid
        print("currently logged in : \(loggedInUser)")
        let nameID = message.fromID
        print("the guy who is sending the message: \(nameID)")
        print("i enter tableview")
        if nameID == loggedInUser {
            //cell.senderName.text = "hi"
                let reference = FIRDatabase.database().reference().child("Users").child(message.destinationID!)
                reference.observeSingleEvent(of: .value, with: { (snapshot) in
                    let user = snapshot.value as! [String: Any]
                    cell.senderName.text = user["username"] as! String?
                })
            print("logged in user and name id are the same")
        }
        else{
            
            //cell.senderName.text = ""
            //cell.timeStamp.text = String(describing: message.timestamp!)
            let reference = FIRDatabase.database().reference().child("Users").child(message.destinationID!)
            reference.observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot.value!)
            })
           // cell.senderName.text = FIRDatabase.database().reference().child("Users").child(nameID!).value(forKey: "username") as! String?
            print("logged in user and name id are not the same")
        }
        
        print("sendername = \(cell.senderName.text)")
        
        
        //cell.senderName.text = message.name
        
        cell.timeStamp.text = String(describing: message.timestamp!)
        
//        let quer = FIRDatabase.database().reference().queryOrderedByKey().queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
//            
//            print(snapshot)
//            
//        })
//        
        
        
//        let job = jobData[indexPath.row]
//        cell.postLabel.text = job.jobName
//        cell.postPrice.text = String(describing: job.price!)
   

  
       
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
        //ref = FIRDatabase.database().reference().child("Messages").child("-KiCP4P4Gw8uw_3QWvGj");
        ref = FIRDatabase.database().reference().child("Messages");
        ref.observe(FIRDataEventType.value, with: {(snapshot)
            in
            if snapshot.childrenCount>0{
                               // for jobs in snapshot.children.allObjects as![FIRDataSnapshot]{
                
                self.messageData.removeAll()
                
                for messages in snapshot.children.allObjects as! [FIRDataSnapshot]{

                    let message =  messages.value as? [String: AnyObject]

                        let fromID = message?["destinationID"];
                        let toID = message?["fromID"];
                        let text = message?["text"];
                        let timestamp = message?["timestamp"];
                   
                        let newMessageData = Message(fromID: toID as? String, text: text as? String, timestamp: timestamp as? String, destinationID: fromID as? String)
                        
                        self.messageData.insert(newMessageData, at: 0)
                    print("messageData size = \(self.messageData.count)")
                }

            }
            
            self.tableView.reloadData()
                //self.animateTable()//animate in progress
        })

    
    }

    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//
//        print("self sender disp name = \(self.senderDisplayName!)");
//        print(sender)
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
//                chatVC?.selectedText = messageData[indexPath.row].text!
//                chatVC?.selectedtimeStamp = messageData[indexPath.row].timestamp!
//                chatVC?.selectedMessageID = messageData[indexPath.row].messageID!
//                chatVC?.selectedtoID = messageData[indexPath.row].toID!
//                chatVC?.selectedfromID = messageData[indexPath.row].fromID!
//                
//                chatVC?.selectedchannelID = messageData[indexPath.row].channelID!
                
                
                
                
//                let messageD = sender as? Message
//                chatVC?.message = messageD
//                chatVC?.messageRef = messageRef.child(messageD.messageID!)
                
            }
        }
    }

}


