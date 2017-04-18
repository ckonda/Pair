//
//  offerComposeViewController.swift
//  Pair
//
//  Created by Chatan Konda on 4/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth



class offerComposeViewController: UIViewController, UITextFieldDelegate {
    
    
    var ref: FIRDatabaseReference?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        offerType.delegate = self
        offerSkill.delegate = self
        offerPrice.delegate = self
        


    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        offerType.resignFirstResponder()
        offerSkill.resignFirstResponder()
        offerPrice.resignFirstResponder()
    }
    
    
    @IBOutlet weak var offerType: UITextField!
    @IBOutlet weak var offerSkill: UITextField!
    @IBOutlet weak var offerPrice: UITextField!

 
    
    func textFieldShouldReturn(_ jobType: UITextField) -> Bool {
        self.offerType.resignFirstResponder()//resign keyboard when entered
        self.offerSkill.resignFirstResponder()
        self.offerPrice.resignFirstResponder()
        
        return true
    }

    
    
    
    @IBAction func cancelPost(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func postAction(_ sender: Any) {
        
        
        
        let OfferType = offerType.text!
        let OfferSkill = offerSkill.text!
        let OfferPrice = Int(offerPrice.text!)
        
        let postRef =  self.ref?.child("Offers").childByAutoId()
        let offerId = postRef?.key

        
        
        let offerData = [
        "title": OfferType,
        "price": OfferPrice!,
        "skill":OfferSkill,
        "username": AppDelegate.user.username!,
         "offerID": offerId!
        ] as [String : Any]
        
        
        postRef?.setValue(offerData)
        
        presentingViewController?.dismiss(animated: true, completion: nil)
        
        
        
    }
    
    
    

}
