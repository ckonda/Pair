//
//  ComposeViewController.swift
//  Pair
//
//  Created by Chatan Konda on 3/28/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ComposeViewController: UIViewController {
    
    var ref: FIRDatabaseReference?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
       

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var jobType: UITextField!//box1
    @IBOutlet weak var jobDescription: UITextField!//box2
    @IBOutlet weak var jobPrice: UITextField!//box3
    
    
    
    
    @IBAction func addPost(_ sender: Any) {
        //post to MainTableViewController as an off
        //TO DO: post jobData to Firebase
        //dismiss the view
        
        ref?.child("Jobs").childByAutoId().setValue(jobDescription)//post job descript
        
        presentingViewController?.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func cancelPost(_ sender: Any) {
        //cancel post and dismiss View to return to MainTableViewController
        presentingViewController?.dismiss(animated: true, completion: nil)
        
    }

}
