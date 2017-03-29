//
//  ComposeViewController.swift
//  Pair
//
//  Created by Chatan Konda on 3/28/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var jobType: UITextField!//box1
    @IBOutlet weak var jobDescription: UITextField!//box2
    @IBOutlet weak var jobPrice: UITextField!//box3
    
    
    
    
    @IBAction func addPost(_ sender: Any) {
        //post to MainTableViewController as an off
        
    }

    @IBAction func cancelPost(_ sender: Any) {
        //cancel post and return to MainTableViewController
        dismiss(animated: true, completion: nil)
        
    }

}
