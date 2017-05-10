//
//  offerBidViewController.swift
//  Pair
//
//  Created by Chatan Konda on 4/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase



class offerBidViewController: UIViewController, UITextFieldDelegate {
    
    
    var ref: FIRDatabaseReference!
  //  let dbRef = FIRDatabase.database().reference()
    
    
    public var postID = String()

    public var selectedName = String()
    public var selectedSkill = String()
    public var selectedID = String()//the ID for the current post

    public var name = String()
    public var toID = String()
    

    public var bidpictureUrl = String()
    @IBOutlet weak var posterName: UILabel!
    
    

    @IBOutlet weak var bidProfilePicture: UIImageView!
    
    
    @IBOutlet weak var username: UILabel!
    
   
    @IBOutlet weak var userDescription: UITextView!

    
    @IBOutlet weak var bidEnter: UITextField!
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        bidEnter.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        bidEnter.resignFirstResponder()
        
        return true
        
    }
    
  
    @IBAction func cancelButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }

    
    

    
    @IBAction func bidButton(_ sender: Any) {
        
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let stringDate = dateFormatter.string(from: date)
        
        if let text = bidEnter.text {//String to variable
            guard let bid = Int(text) else {//variable to integers to BID
                // return bid
                return
            }
            let newPrice = bid
            
            let bidRef = FIRDatabase.database().reference().child("Bids")
            
            let bidCreate = bidRef.childByAutoId()
            let newKey = bidCreate.key//key for message ID
            
            
            let offerBid = [
                "bidderID": AppDelegate.user.userID!,
                "ownerID": toID,
                "postID": selectedID,
                "postPrice": newPrice,
                "timestamp": stringDate,
                "name": AppDelegate.user.username!,
                "description": selectedName,
                ] as [String : Any]
            
            bidCreate.setValue(offerBid)
            
            
        }
        
        
        dismiss(animated: true, completion: nil)
        

       
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        bidEnter.delegate = self
        
        userDescription.text = selectedSkill
        
        username.text = selectedName
        
        bidEnter.keyboardType = UIKeyboardType.numberPad

        
    }
    

    
    


}
