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

class rateViewController: UIViewController {
    
    let ref = FIRDatabase.database().reference().child("Ratings")

    @IBOutlet weak var rating: UITextField!
    
    @IBOutlet weak var comments: UITextField!
    
    var userID: String?
    
    @IBAction func submitRating(_ sender: Any) {
        print("user youre rating = \(userID)")
        var ratingData: String
        var commentsData: String
        if rating.text != nil && comments.text != nil {
            
            
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
  

}
