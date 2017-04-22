//
//  MenuViewController.swift
//  Pair
//
//  Created by Chatan Konda on 4/18/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit


import UIKit

class MenuViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var myImageView: UIImageView!

    @IBAction func importImage(_ sender: Any) {
    
    let image = UIImagePickerController()
    image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            //after complete
        }
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            myImageView.image = image
        }
        else
        {
            //error message
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var emailLabel: UILabel!
    
    
    @IBOutlet weak var uName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(emailLabel.text!)
        print("\n")
        
        
        if let email = UserDefaults.standard.object(forKey: "email") as? String
        {
            emailLabel.text?.append(email)
        }
        
        
        uName.text?.append(AppDelegate.user.username!)
        print(emailLabel.text!)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
