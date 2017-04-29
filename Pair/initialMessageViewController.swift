//
//  initialMessageViewController.swift
//  Pair
//
//  Created by Chatan Konda on 4/27/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class initialMessageViewController: UIViewController {
    @IBOutlet weak var typeMessageLabel: UILabel!
    
    @IBOutlet weak var messageBoxLabel: UITextView!
    @IBOutlet weak var acceptedLabel: UILabel!
    var ref = FIRDatabase.database().reference()
    var loc: Int?
    var currentBid: pastBids?
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func sendButton(_ sender: Any) {
        if(messageBoxLabel.text != nil){
            let user1 = AppDelegate.user.userID!
            let user2 = currentBid?.bidderID!
            let channelID: String?
            if user1>user2!{
                channelID = user1 + "*" + user2!
            }
            else{
                channelID = user2! + "*" + user1
            }
            let messageRef = ref.child("Channels").child(channelID!)
            let messageID = messageRef.childByAutoId()
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
            let stringDate = dateFormatter.string(from: date)
            let messageJSON = [
                "destinationID": currentBid?.bidderID!,
                "fromID": AppDelegate.user.userID!,
                "text": messageBoxLabel.text!,
                "timestamp": stringDate
            ]
            messageID.setValue(messageJSON)
            dismiss(animated: true, completion: nil)
        }
    }
    var user1ID: String?
    var user2ID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    
    
    
    
}
