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
import FirebaseCore
import FirebaseAuth
//import Fire
import WebKit

class ComposeViewController: UIViewController {
    
    var ref: FIRDatabaseReference?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference() //.child("Jobs").childByAutoId()
   
       
        
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var jobType: UITextField!//box1
    @IBOutlet weak var jobDescription: UITextField!//box2
    @IBOutlet weak var jobPrice: UITextField!//box3
    //@IBOutlet weak var jobTitle: UITextField!//box3
    //@IBOutlet weak var username: UITextField!//box3
    
    
    @IBAction func addPost(_ sender: Any) {
        //post to MainTableViewController as an off
        //TO DO: post jobData to Firebase
        //dismiss the view
    //ref?.child("Jobs").childByAutoId().setValue(jobDescription)
        //let userID = ref?.childByAutoId().key
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
        
        
    
        
        //jobType.text = ""
        //jobDescription.text = ""
        //jobPrice.text = ""
        
        //self.ref?.child("Jobs").child("ref").setValue("thing")
        //newRef.childByAutoId().setValue(job1)
       // ref?.child("Jobs").child(job1).setValue(["Descriptions": job2])
        //ref?.child("Jobs").child(job1).setValue(["Price": job3])
        
    }

    @IBAction func cancelPost(_ sender: Any) {
        //cancel post and dismiss View to return to MainTableViewController
        presentingViewController?.dismiss(animated: true, completion: nil)
        
    }

}
