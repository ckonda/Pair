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
    var channelData = [Channel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var ref: FIRDatabaseReference!
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //observeMessages()
        tableView.delegate = self
        tableView.dataSource = self

        ref = FIRDatabase.database().reference().child("Channels");
        print(ref)
        ref.observe(FIRDataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                //print(snapshot.)
                self.channelData.removeAll()
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
    

    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessagesTableViewCell
        
        let channel = channelData[indexPath.row]

        let loggedInUser = FIRAuth.auth()?.currentUser?.uid
        print("chanel disp id = \(channel.channelDispID!)")
        let nameIDPath = FIRDatabase.database().reference().child("Users").child(channel.channelDispID!)
        //print("name = \(nameJSON["username"] as! String?)")
        nameIDPath.observeSingleEvent(of: .value, with: { (snapshot) in
            let nameJSON = snapshot.value as! [String: Any]
            cell.senderName.text = (nameJSON["username"] as! String?)!
            
            if let profileImage = nameJSON["profileImageUrl"] as! String? {
                
                let url = URL(string: profileImage)
                print("before")
                URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                    if error != nil{
                        print(error!)//download hit error so return out
                    }
                    DispatchQueue.main.async(execute: {
                        cell.messagePicture.image = UIImage(data: data!)
                    })
                }).resume()
            }
            
        })//end of UserObserve completion block
   
//        let timepathID = FIRDatabase.database().reference().child("Channels").child(channel.channelDispID!)
        

        cell.senderName.text = channel.channelDispID
        
        
        
        let timePath = FIRDatabase.database().reference().child("Channels").child(channel.channelDispID!)
        //print("name = \(nameJSON["username"] as! String?)")
        timePath.observeSingleEvent(of: .childAdded, with: { (snapshot) in
            print(snapshot)
            let time = snapshot.value as! [String: Any]
            
            cell.timeStamp.text = time["timestamp"] as! String
            
            
        })
        
        
       
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
   
    
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "gotoMessage") {
            // initialize new view controller and cast it as your view controller
            if let indexPath = self.tableView.indexPathForSelectedRow{
                
                
                let chatVC = segue.destination as? chatViewController
                
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
                
            }
        }
    }

}


