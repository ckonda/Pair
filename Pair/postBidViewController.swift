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
        
        let messageRef = self.ref?.child("Messages").childByAutoId()//new channel created
        //let messageRef2 = self.ref?.child("Messages").queryEqual(toValue: "zyDkBgJKhdYka1oirEWnFZTcSIh1")
        
        //let messageRef3 = self.ref?.child("Messages").root.queryEqual(toValue: "zyDkBgJKhdYka1oirEWnFZTcSIh1")
        
        //print(messageRef3)
        
        let channel: String = checkIfThreadExists(destID: toID)!
        if channel == "" {
            print("We will have to make a new Channel because there is no channel that holds these two users")
        }
        else{
            print("we will continue our messages in the channel \(channel)")
        }
        //print(messageRef2)
        //print(messageRef.value)
        let channelID = messageRef?.key//key for channel ID
        let newRef = messageRef?.childByAutoId()//message ID created
        let newKey = newRef?.key//key for message ID
        let messageItem = [
            "fromID": AppDelegate.user.userID!,
            "toID": toID,
            "timestamp": timestamp,
            "text": messageexample,
            "messageID": newKey!,
            "channelID": channelID!,
            "name": AppDelegate.user.username!
        ]  as [String : Any]
        
        //newRef?.setValue(messageItem)
            
        dismiss(animated: true, completion: nil)
        
        
    }
    
    func checkIfThreadExists(destID: String) -> String?{
        //let var resultChannelID: String? = nil
        var resultChannelID = ""
        var breakLoop: BooleanLiteralType = false;
        ref = FIRDatabase.database().reference().child("Messages");
        ref.observe(FIRDataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                //var resultChannelID = ""
                let enumerator = snapshot.children
                while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                    let newObj = rest.children
                    while let rest1 = newObj.nextObject() as? FIRDataSnapshot{
                        // let messageInfo = rest1.children
                        let dataDict =  rest1.value as? NSDictionary
                        let sourceIDDB = dataDict?["fromID"] as! String?;
                        let destIDDB = dataDict?["toID"] as! String?;
                        let text = dataDict?["text"];
                        let name = dataDict?["name"];
                        let timestamp = dataDict?["timestamp"];
                        let channelID = dataDict?["channelID"] as? String!;
                        let messageID = dataDict?["messageID"];

                        if(sourceIDDB == AppDelegate.user.userID && destIDDB == destID){
                            print("Channel: \(channelID!)")
                            print("Sending from: \(AppDelegate.user.userID)")
                            print("Sending to: \(destID)")
                            //return channelID
                            resultChannelID = channelID!
                            print("resultChannelID after one of the if else: \(channelID!!)")
                        }
                        else if(sourceIDDB == destID && destIDDB == AppDelegate.user.userID){
                            print("Channel: \(channelID!)")
                            print("Sending from: \(AppDelegate.user.userID)")
                            print("Sending to: \(destID)")
                            //return channelID
                            resultChannelID = channelID!
                            print("resultChannelID after one of the if else: \(channelID!!)")
                        }
                        else{
                            //print("Channel not between \(AppDelegate.user.userID) and \(destID)")
                            continue
                        }
                        print("channel id result = \(resultChannelID)")
                    }
                    //print("success")
                }
                
            }
            return resultChannelID
        })
        //print("resultChannelID = \(resultChannelID)")
        //return resultChannelID
    }




    override func viewDidLoad() {
        super.viewDidLoad()
        
        jobDescription.text = selectedDescription
        jobName.text = selectedName
        
        
        ref = FIRDatabase.database().reference()
        
  
        
    }
    
    
    
    
    
    
    
    
    
    



}
