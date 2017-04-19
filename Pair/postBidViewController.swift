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
        
        let messageRef = self.ref?.child("Messages").childByAutoId()
        let messageID = messageRef?.key
            let messageItem = [
            "fromID": AppDelegate.user.userID!,
            "toID": toID,
            "timestamp": timestamp,
            "text": messageexample,
            "messageID": messageID!
            ]  as [String : Any]
        
        messageRef?.setValue(messageItem)
            

        
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jobDescription.text = selectedDescription
        jobName.text = selectedName
        
        
        ref = FIRDatabase.database().reference()
        
  
        
    }
    
    
    
    
    
    
    
    
    
    



}
