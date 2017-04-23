//
//  postBidViewController.swift
//  Pair
//
//  Created by Chatan Konda on 4/14/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase



class postBidViewController: UIViewController, UITextFieldDelegate {
    
    
    var ref: FIRDatabaseReference!
    
    public var postID = String()
    
    private lazy var messageRef:FIRDatabaseReference = FIRDatabase.database().reference().child("Messages")
    
    
    public var selectedName = String()
    public var selectedDescription = String()
    public var selectedPrice = Int()
    public var selectedID = String()//the ID for the current post

    
    public var toID = String()
    
    
    
  
    
    @IBOutlet weak var cancelPost: UIBarButtonItem!
    
    
    @IBOutlet weak var jobName: UILabel!
    
    @IBOutlet weak var jobDescription: UILabel!
    

    
    
    
    
    
    
//    @IBOutlet weak var offerName: UILabel!
//    
//    @IBOutlet weak var jobDescription: UILabel!
    
    
    

    @IBAction func cancelView(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    var messageexample = "hello"
    
    
    @IBAction func bidButton(_ sender: Any) {
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        let timestamp = "\(hour):\(minutes):\(seconds)"
        
        //let
        
        let messageRef = self.ref?.child("Bids").childByAutoId()//new channel created
        //let messageRef2 = self.ref?.child("Messages").queryEqual(toValue: "zyDkBgJKhdYka1oirEWnFZTcSIh1")
        
        //let messageRef3 = self.ref?.child("Messages").root.queryEqual(toValue: "zyDkBgJKhdYka1oirEWnFZTcSIh1")
        
        //print(messageRef3)
        
     
      
        //print(messageRef2)
        //print(messageRef.value)
        let channelID = messageRef?.key//key for channel ID
        let newRef = messageRef?.childByAutoId()//message ID created
        let newKey = newRef?.key//key for message ID
        
        
//        
//        let messageItem = [
//            "fromID": AppDelegate.user.userID!,
//            "toID": toID,
//            "timestamp": timestamp,
//            "text": messageexample,
//            "messageID": newKey!,
//            "channelID": channelID!,
//            "name": AppDelegate.user.username!
//        ]  as [String : Any]
        
        
        let postBid = [
            "bidderID": toID,
            "ownerID": UserDefaults.standard.object(forKey: "userID")!,
            "postID": selectedID,
            "postPrice": selectedPrice
            ] as [String : Any]
        
         messageRef?.setValue(postBid)
        /*

        let postBid = [
            "title": JobType,
            "price": JobPrice!,
            "description": JobDescription,
            "name": UserDefaults.standard.object(forKey: "username")!,
            "postid": postId!,
            "location": "Merced, CA",
            "username": UserDefaults.standard.object(forKey: "userID")!,
            "profileImageUrl": UserDefaults.standard.object(forKey: "profileImageUrl")!
            ] as [String : Any]
*/
        
        //newRef?.setValue(messageItem)
            
        dismiss(animated: true, completion: nil)
        
        
    }
    
   



    override func viewDidLoad() {
        super.viewDidLoad()
        
        jobDescription.text = selectedDescription
        jobName.text = selectedName
        
        
        ref = FIRDatabase.database().reference()
        
  
        
    }
    
    
    
    
    
    
    
    
    
    



}
