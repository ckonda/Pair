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
        print(emailLabel.text!)
        print("\n")
        emailLabel.text?.append( AppDelegate.user.email!)
        uName.text?.append(AppDelegate.user.username!)
        print(emailLabel.text!)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}