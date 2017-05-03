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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jobName.text = selectedName
        jobDescription.text = selectedDescription
        bidEnter.delegate = self
        
        bidEnter.keyboardType = UIKeyboardType.numberPad
        
        
    }
    
    
    var ref: FIRDatabaseReference!
    
    public var postID = String()
    
    
    
    public var selectedName = String()
    public var selectedDescription = String()
    public var selectedPrice = Int()
    public var selectedID = String()//the ID for the current post

    public var name = String()
    public var toID = String()
    
    
    
    @IBOutlet weak var cancelPost: UIBarButtonItem!
    
    @IBOutlet weak var jobName: UILabel!
    
    @IBOutlet weak var jobDescription: UILabel!
    
    @IBOutlet weak var bidEnter: UITextField!
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        bidEnter.resignFirstResponder()
      
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        bidEnter.resignFirstResponder()

        return true
        
    }
    
    
    @IBAction func ratingsButton(_ sender: Any) {
        
        performSegue(withIdentifier: "toPosterRating", sender: self)
        
    }//segue to ratings
    
    
    
    

    @IBAction func cancelView(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    var messageexample = "hello"
    
    
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
         //   let newKey = bidCreate?.key//key for message ID
            
            print(newPrice)
            print(selectedID)
            print(selectedDescription)
            
            
            let postBid = [
                "bidderID": AppDelegate.user.userID!,
                "ownerID": toID,
                "postID": selectedID,
                "postPrice": newPrice,
                "timestamp": stringDate,
                "name": AppDelegate.user.username!,
                "description": selectedName,
                ] as [String : Any]
     
            bidCreate.setValue(postBid)
            

        }
        
        
        dismiss(animated: true, completion: nil)
        
        
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toPosterRating"){
            
            let destination = segue.destination as! bidRatingViewController
            destination.postuserID = toID
            

        }
        
    }

    
    
    
    

    
    
    



}
