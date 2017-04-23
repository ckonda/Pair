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
    
    
    @IBOutlet weak var bidEnter: UITextField!
    

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
        
        if let text = bidEnter.text {//String to variable
            guard let bid = Int(text) else {//variable to integers to BID
                // return bid
                return
            }
            let newPrice = bid
            
            
            let bidRef = self.ref?.child("Bids").childByAutoId()//new channel created
            
            
            let newKey = bidRef?.key//key for message ID
            let postBid = [
                "bidderID": AppDelegate.user.userID!,
                "ownerID": toID,
                "postID": selectedID,
                "postPrice": newPrice,
                "timestamp": timestamp
                ] as [String : Any]
            
            bidRef?.setValue(postBid)//setting val
            
        
        }
        
        
//        let bidRef = self.ref?.child("Bids").childByAutoId()//new channel created
//     
//
//        let newKey = bidRef?.key//key for message ID
//        let postBid = [
//            "bidderID": toID,
//            "ownerID": UserDefaults.standard.object(forKey: "userID")!,
//            "postID": selectedID,
//            "postPrice": ,
//            "timestamp": timestamp
//            ] as [String : Any]
//        
//        bidRef?.setValue(postBid)//setting val
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
   



    override func viewDidLoad() {
        super.viewDidLoad()
        
        jobDescription.text = selectedDescription
        jobName.text = selectedName
        
        
        ref = FIRDatabase.database().reference()
        
  
        
    }
    
    
    
    
    
    
    
    
    
    



}
