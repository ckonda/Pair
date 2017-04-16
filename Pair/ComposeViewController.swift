//
//  ComposeViewController.swift
//  Pair
//
//  Created by Chatan Konda on 3/28/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ComposeViewController: UIViewController, UITextFieldDelegate {
    
    var ref: FIRDatabaseReference?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        ref = FIRDatabase.database().reference()
        
          jobType.delegate = self
          jobDescription.delegate = self
          jobPrice.delegate = self
        
 
    }

    @IBOutlet weak var jobType: UITextField!//box1
    @IBOutlet weak var jobDescription: UITextField!//box2
    @IBOutlet weak var jobPrice: UITextField!//box3
    
    func textFieldShouldReturn(_ jobType: UITextField) -> Bool {
          self.jobType.resignFirstResponder()//resign keyboard when entered

     return true
    }

    
   
    
    
    
    @IBAction func addPost(_ sender: Any) {
        //post to MainTableViewController as an off
        //TO DO: post jobData to Firebase
        //dismiss the view
    //ref?.child("Jobs").childByAutoId().setValue(jobDescription)
        
        
        presentingViewController?.dismiss(animated: true, completion: nil)
        let job1 = jobType.text!
        let job2 = jobDescription.text!
        let job3 = jobPrice.text!
        //let job4 = username.text!
        
        
        
        
        
        
        
        
        //  let ref = FIRDatabase.database().reference()
        let postData = [
            "title": job1,
            //"job": "a", //as! NSString,
            "price": job2, //as! NSString,
            //"username": job4,
            "description": job2
            ] as [String : Any]
        /*self.ref?.child("Jobs").child(userID!).setValue("jobtype", forUndefinedKey: "a")
         self.ref?.child("Jobs").child(userID!).setValue("jobdescription", forUndefinedKey: "b")
         self.ref?.child("Jobs").child(userID!).setValue("jobtype", forUndefinedKey: "c")*/
        self.ref?.child("Jobs").childByAutoId().setValue(postData)
        
        
        
        
//        
//        jobType.text = ""
//        jobDescription.text = ""
//        jobPrice.text = ""
        

        
        presentingViewController?.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func cancelPost(_ sender: Any) {
        //cancel post and dismiss View to return to MainTableViewController
        presentingViewController?.dismiss(animated: true, completion: nil)
        
    }

}
