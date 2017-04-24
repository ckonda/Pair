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
    
    
//    func setup() {
//        self.senderId = "1234"
//        self.senderDisplayName = "TEST"
//    }

    
    
    //     cell.senderName.text = message.name
    //cell.timeStamp.text = String(describing: message.timestamp!)
    //var channelDictionary = [String: Message]()
    var channelData = [Channel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var ref: FIRDatabaseReference!
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //observeMessages()
        tableView.delegate = self
        tableView.dataSource = self
        //ref = FIRDatabase.database().reference().child("Messages").child("-KiCP4P4Gw8uw_3QWvGj");
        ref = FIRDatabase.database().reference().child("Channels");
        print(ref)
        ref.observe(FIRDataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                //print(snapshot.)
                //self.messageData.removeAll()
                //print("messages in snapshot")
                for channels in snapshot.children.allObjects as! [FIRDataSnapshot]{
                    //print(channels.key)
                    let channelName = channels.key as String
                    var usersInChannel = channelName.components(separatedBy: "*")
                    print("settings users")
                    let user1 = usersInChannel[0]
                    print("set user1 to \(user1)")
                    let user2 = usersInChannel[1]
                    print("set user2 to \(user2)")
                    let displayName: String?
                    if AppDelegate.user.userID == user1{
                        displayName = user2
                    }
                    else{
                        displayName = user1
                    }
                    
                    let currentChannel = Channel(channelID: channelName, user1ID: user1, user2ID: user2, channelDispID: displayName)
                    if AppDelegate.user.userID == user1 || AppDelegate.user.userID == user2 {
                        self.channelData.insert(currentChannel, at: 0)
                    }
                    //print(channels.value)
                }
                 // self.tableView.reloadData()
            }
            print("size of mmessage data = \(self.channelData.count)")
            self.tableView.reloadData()
           // self.animateTable()//animate in progress
        })

       print("finished observing")

        //print("size of mmessage data = \(messageData.count)")
        
       //self.tableView.reloadData()
        
    }
    
    
//    
//    deinit {
//        if let refhandle = messageRefHandle{
//            messageRef.removeObserver(withHandle: refhandle)
//        }
//    }
//    

    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessagesTableViewCell
        print("REACHES THIS")
        let channel = channelData[indexPath.row]
        //let nameUser = channel.channelDispID
        
        let loggedInUser = FIRAuth.auth()?.currentUser?.uid
        print("chanel disp id = \(channel.channelDispID!)")
        let nameIDPath = FIRDatabase.database().reference().child("Users").child(channel.channelDispID!)
        print("name key = \(nameIDPath)")
       // let nameJSON = nameIDPath.value(forKey: "username")
        
        //print("name = \(nameJSON["username"] as! String?)")
        nameIDPath.observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            let nameJSON = snapshot.value as! [String: Any]
            print("username is = \(nameJSON["username"] as! String?)")
            cell.senderName.text = (nameJSON["username"] as! String?)!
            
        })
            
            //.value(forKey: "username") as! String
        //cell.senderName.text = channel.channelDispID
        cell.senderName.text = channel.channelDispID
        cell.timeStamp.text = "hh:mm:ss"
        
        
        /*print("currently logged in : \(loggedInUser)")
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
*/
  
       
        return cell
    }
    
    
    
    @IBAction func cancelView(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channelData.count
    }
    
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let message = channelData[(indexPath as NSIndexPath).row]
        self.performSegue(withIdentifier: "gotoMessage", sender: message)
    }
   
    
    
    

    
//    
//    private func observeMessages(){
//        
//        tableView.delegate = self
//        tableView.dataSource = self
//        //ref = FIRDatabase.database().reference().child("Messages").child("-KiCP4P4Gw8uw_3QWvGj");
//        ref = FIRDatabase.database().reference().child("Messages");
//        ref.observe(FIRDataEventType.value, with: {(snapshot)
//            in
//            if snapshot.childrenCount>0{
//                               // for jobs in snapshot.children.allObjects as![FIRDataSnapshot]{
//                
//                self.messageData.removeAll()
//                
//                for messages in snapshot.children.allObjects as! [FIRDataSnapshot]{
//
//                    let message =  messages.value as? [String: AnyObject]
//
//                        let fromID = message?["destinationID"];
//                        let toID = message?["fromID"];
//                        let text = message?["text"];
//                        let timestamp = message?["timestamp"];
//                   
//                        let newMessageData = Message(fromID: toID as? String, text: text as? String, timestamp: timestamp as? String, destinationID: fromID as? String)
//                        
//                        self.messageData.insert(newMessageData, at: 0)
//                    print("messageData size = \(self.messageData.count)")
//                }
//
//            }
//            
//            self.tableView.reloadData()
//                //self.animateTable()//animate in progress
//        })
//        
//}

    
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
                
                //chatVC?.message = messageData[indexPath.row].text!

                
               // chatVC?.selectedtimeStamp = messageData[indexPath.row].timestamp!
  
                //chatVC?.selectedID1 = channelData[indexPath.row].user1ID!
              
                
                //channel id
                
                chatVC?.selectedchannelID = channelData[indexPath.row].channelID!
                
                //app delegate user -> guy who's signed in aka the sender
                    chatVC?.senderId = AppDelegate.user.userID
                //destinationID -> the guy who you're talking to
                
            if channelData[indexPath.row].user1ID == AppDelegate.user.userID {
                chatVC?.chatUserID = channelData[indexPath.row].user2ID!
            }
            else{
                chatVC?.chatUserID = channelData[indexPath.row].user1ID!
            }
                //sender display name
                    chatVC?.senderDisplayName = AppDelegate.user.username!
                
//                chatVC?.selectedfromID = messageData[indexPath.row].fromID!*/
                
//                let messageD = sender as? Message
//                chatVC?.message = messageD
//                chatVC?.messageRef = messageRef.child(messageD.messageID!)
                
            }
        }
    }

}


