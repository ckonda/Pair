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

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        
        
        title = "Messages"
        observeMessages()
       // print(messageData[0].name!)
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
        
        cell.senderName.text = message.name
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
   
    
    func parseJSON(){
        
        let path = "https://pair-4a005.firebaseio.com/"
        
        //let jsonData = NSData(contentsOf: path as URL!)
        //let readableJSON = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
    }
    
    
    

    
    
    private func observeMessages(){
        
        tableView.delegate = self
        tableView.dataSource = self
        //ref = FIRDatabase.database().reference().child("Messages").child("-KiCP4P4Gw8uw_3QWvGj");
        ref = FIRDatabase.database().reference().child("Messages");
        ref.observe(FIRDataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.messageData.removeAll()
                
                let enumerator = snapshot.children
                
                while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                    //print("..")
                    
                    //print(rest.key)
                    
                    let newObj = rest.children
                    while let rest1 = newObj.nextObject() as? FIRDataSnapshot{
                       // let messageInfo = rest1.children
                        let dataDict =  rest1.value as? NSDictionary

                        let fromID = dataDict?["fromID"];
                        let toID = dataDict?["toID"];
                        let text = dataDict?["text"];
                        let name = dataDict?["name"];
                        let timestamp = dataDict?["timestamp"];
                        let channelID = dataDict?["channelID"];
                        let messageID = dataDict?["messageID"];
                        
                        let newMessageData = Message(fromID: fromID as? String, text: text as? String, timestamp: timestamp as? String, toID: toID as? String, messageID: messageID as? String, channelID: channelID as? String, name: name as? String)
                        
                        self.messageData.insert(newMessageData, at: 0)
                    }

                }
                self.tableView.reloadData()
                //self.animateTable()//animate in progress
            }
        })
        if(messageData.count > 0){
            print("messageData has stuff")
        }
        else{
            print("messageData is empty")
        }
        
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
                chatVC?.selectedText = messageData[indexPath.row].text!
                chatVC?.selectedtimeStamp = messageData[indexPath.row].timestamp!
                chatVC?.selectedMessageID = messageData[indexPath.row].messageID!
                chatVC?.selectedtoID = messageData[indexPath.row].toID!
                chatVC?.selectedfromID = messageData[indexPath.row].fromID!
                
                chatVC?.selectedchannelID = messageData[indexPath.row].channelID!
                
                
                
                
//                let messageD = sender as? Message
//                chatVC?.message = messageD
//                chatVC?.messageRef = messageRef.child(messageD.messageID!)
                
            }
        }
    }
    
    
    
    
    
    


}
