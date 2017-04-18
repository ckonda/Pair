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
    let dbRef = FIRDatabase.database().reference()
    
    
    
    
    public var selecteduserName = String()
    public var selectedSkill = String()
    public var selectedPrice = Int()
    //public var selectedLocation = String()
    
    
    

    @IBOutlet weak var userDescription: UILabel!//user Skill
    
    @IBOutlet weak var username: UILabel!
    
   
    @IBOutlet weak var offerPrice: UILabel!
    
    @IBOutlet weak var bidEnter: UITextField!
    
    
    func textFieldShouldReturn(_ bidEnter: UITextField) -> Bool {
        //self.view.endEditing()
        
        bidEnter.resignFirstResponder()
        return true
    }
    
  
    @IBAction func cancelButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
//     var input:Int = sender.titleLabel as Int
    
    

    
    @IBAction func bidButton(_ sender: Any) {
        
        
        ref = dbRef.child("Offer").child("tutor")
 
        if let text = bidEnter.text {//String to variable
            guard let bid = Int(text) else {//variable to integers to BID
               // return bid
                return
            }
            let selectedPrice = bid
            
            //ref = dbRef.child("Offer")
            //child("tutor")
            
            let oldBid = ref.observe(FIRDataEventType.value, with: { (snapshot) in
                
                if let dict = snapshot.value as? NSDictionary  {
                    if let oldPrice = dict.value(forKey: "price"){
                        print(oldPrice)
                    }
                }
                else {
                    print("Bid is nil")
                }
            })
            
            let biddey = Int(oldBid)
              print(biddey)

        
            if selectedPrice > biddey {
                 // ref.updateChildValues(["price": selectedPrice])
                   ref.setValue(selectedPrice, forKey: "price")
            }
            else{
                print("Bid Higher Please!")
                bidInvalid.isHidden = false
                bidInvalid.setNeedsDisplay()
            }
            return
        }
       
    }
    
    
    @IBOutlet weak var bidInvalid: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bidInvalid.isHidden = true
        
    
        bidEnter.delegate = self
        
        
         username.text = selecteduserName
        userDescription.text = selectedSkill
    //  offerPrice.text = selectedPrice as String

        
    }

    
    
    


}
