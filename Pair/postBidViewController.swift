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
    
    
    var ref: FIRDatabaseReference!
    
    public var postID = String()
    
    
    
    public var selectedName = String()
    public var selectedDescription = String()
    public var selectedPrice = Int()
    public var selectedID = String()//the ID for the current post

  
    
    @IBOutlet weak var cancelPost: UIBarButtonItem!
    
    
    @IBOutlet weak var jobName: UILabel!
    
    @IBOutlet weak var jobDescription: UILabel!
    
    
    
    
    
    
    
    
//    @IBOutlet weak var offerName: UILabel!
//    
//    @IBOutlet weak var jobDescription: UILabel!
    
    
    

    @IBAction func cancelView(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func bidButton(_ sender: Any) {
        
   
        
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jobDescription.text = selectedDescription
        jobName.text = selectedName
        

        
        
        
        
  
        
    }
    
    
    
    
    
    
    
    
    
    



}
