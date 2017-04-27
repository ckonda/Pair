//
//  MenuViewController.swift
//  Pair
//
//  Created by Chatan Konda on 4/18/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase

import UIKit

class MenuViewController: UIViewController {
    

    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    @IBOutlet weak var uName: UILabel!
    
    
    
    
    let url = AppDelegate.user.profileImageUrl!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         uName.text?.append(AppDelegate.user.username!)
        
        
        FIRStorage.storage().reference(forURL: url).data(withMaxSize: 25 * 1024 * 1024) { (data, error) in
            self.profilePicture.image = UIImage(data: data!)
            
        }
        
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2
        profilePicture.clipsToBounds = true
        profilePicture.layer.borderColor = UIColor.white.cgColor
        profilePicture.layer.borderWidth = 1
        
        

    }
    

    
    
    
    
    
    
    
    
}
