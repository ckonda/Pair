//
//  rateViewController.swift
//  Pair
//
//  Created by Sahil M. Hingorani on 4/26/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class rateViewController: UIViewController, UITextFieldDelegate {
    
    
    let ref = FIRDatabase.database().reference().child("Ratings")


    override func viewDidLoad() {
        super.viewDidLoad()
        comments.layer.borderColor = UIColor.gray.cgColor
        comments.layer.borderWidth = 1.0

    }
    
    var userID:String?
    
    @IBOutlet weak var rating: UITextField!
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        rating.resignFirstResponder()
        comments.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        rating.resignFirstResponder()
        comments.resignFirstResponder()
        
        return true
        
    }
    
    
    
    
    
    @IBOutlet weak var comments: UITextView!
    
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
}
