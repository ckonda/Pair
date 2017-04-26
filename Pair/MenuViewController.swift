//
//  MenuViewController.swift
//  Pair
//
//  Created by Chatan Konda on 4/18/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit


import UIKit

class MenuViewController: UIViewController {
    

    
    @IBOutlet weak var emailLabel: UILabel!
    
    
    @IBOutlet weak var uName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(emailLabel.text!)
        print("\n")
        
        if let email = UserDefaults.standard.object(forKey: "email") as? String
        {
            uName.text?.append(email)
        }
        
//        print(emailLabel.text!)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
