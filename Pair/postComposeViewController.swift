//
//  ComposeViewController.swift
//  Pair
//
//  Created by Chatan Konda on 3/28/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class postComposeViewController: UIViewController, UITextFieldDelegate{
    
    var ref: FIRDatabaseReference?
  


    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        
        
        jobType.delegate = self
        jobDescription.delegate = self
        jobPrice.delegate = self
        
        
            
        jobType.backgroundColor = UIColor.white;
        jobType.alpha = 0.2;
        jobType.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        jobType.layer.cornerRadius = 4.0
        jobDescription.backgroundColor = UIColor.white;
        jobDescription.alpha = 0.2;
        jobDescription.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        jobDescription.layer.cornerRadius = 4.0
        jobPrice.backgroundColor = UIColor.white;
        jobPrice.alpha = 0.2;
        jobPrice.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        jobPrice.layer.cornerRadius = 4.0
        
        
    

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        jobType.resignFirstResponder()
        jobDescription.resignFirstResponder()
        jobPrice.resignFirstResponder()
    }

    
    @IBOutlet weak var jobType: UITextField!
    
    @IBOutlet weak var jobDescription: UITextField!
    
    @IBOutlet weak var jobPrice: UITextField!
    
    
    
    
    func textFieldShouldReturn(_ jobType: UITextField) -> Bool {
          self.jobType.resignFirstResponder()
          self.jobDescription.resignFirstResponder()
          self.jobPrice.resignFirstResponder()

     return true
    }

    
    @IBAction func addPost(_ sender: Any) {
        
        let JobType = jobType.text!
        let JobDescription = jobDescription.text!
        let JobPrice = Int(jobPrice.text!)

        
        let postRef =  self.ref?.child("Jobs").childByAutoId()
        let postId = postRef?.key
        
        
        
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let stringDate = dateFormatter.string(from: date)
        
        print(stringDate)

    
        let postData = [
            "title": JobType,
            "price": JobPrice!,
            "description": JobDescription,
            "name": AppDelegate.user.username!,
            "postid": postId!,
            "location": "Merced, CA",
            "username": AppDelegate.user.userID!,
            "profileImageUrl": AppDelegate.user.profileImageUrl!,
            "timestamp": stringDate
            ] as [String : Any]
        
        
        postRef?.setValue(postData)
        
        dismiss(animated: true, completion: nil)
    }
    

    
    @IBAction func cancelPost(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }

}





