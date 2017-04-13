//
//  offerComposeViewController.swift
//  Pair
//
//  Created by Chatan Konda on 4/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class offerComposeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func cancelPost(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBOutlet weak var offerType: UITextField!
    
    @IBOutlet weak var offerDescription: UITextField!

    @IBOutlet weak var offerPrice: UITextField!
   
    @IBOutlet weak var postAction: UIButton!
    
    @IBAction func postAction(_ sender: Any) {
           presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    

}
