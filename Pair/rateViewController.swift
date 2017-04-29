//
//  rateViewController.swift
//  Pair
//
//  Created by Chatan Konda on 4/25/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class rateViewController: UIViewController , UITextFieldDelegate{
    
    let ref = FIRDatabase.database().reference().child("Ratings")

    @IBOutlet weak var rating: UITextField!
    var userID:String?
    
    
    @IBOutlet weak var comments: UITextView!
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        rating.resignFirstResponder()
        comments.resignFirstResponder()

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        rating.resignFirstResponder()
        comments.resignFirstResponder()
        
        return true
        
    }
    
    
    
    
    
    @IBAction func submitRating(_ sender: Any) {
        print("user youre rating = \(userID)")
        var ratingData: String
        var commentsData: String
        
        if rating.text != nil && comments.text != nil {
            let ratingRef = ref.child(userID!).childByAutoId()
            let ratingData = [
                "comments" : comments.text!,
                "ratingValue" : Int(rating.text!)!,
                "rater": AppDelegate.user.username!,
                "raterid":AppDelegate.user.userID!
            ] as [String : Any]
            ratingRef.setValue(ratingData)
            
            //segue
            
            performSegue(withIdentifier: "goHome", sender: self)
            
        }
        
        
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        comments.layer.borderColor = UIColor(red: 84.0/255.0, green: 211.0/255.0, blue: 187.0/255.0, alpha: 1.0).cgColor
        comments.layer.borderWidth = 1.0
        comments.layer.cornerRadius = 5
        
         rating.keyboardType = UIKeyboardType.numberPad
        
        
    }


    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
  

}
