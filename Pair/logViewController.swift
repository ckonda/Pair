//
//  logViewController.swift
//  Pair
//
//  Created by Chatan Konda on 4/10/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class logViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

   
    }

    @IBOutlet weak var segmentedControl: UISegmentedControl!

    @IBAction func segmentedSelect(_ sender: UISegmentedControl) {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            signinButton.setTitle("Sign in", for: .normal)
            handleLoginRegister()
             print("greetings")
        }else {
            signinButton.setTitle("Join", for: .normal)
            handleLoginRegister()
            print("hello")
        }
    }
    
    @IBOutlet weak var nametextField: UITextField!
    
    @IBOutlet weak var emailtextField: UITextField!

    @IBOutlet weak var passwordtextField: UITextField!
    
    @IBOutlet weak var signinButton: UIButton!
    
    @IBAction func signInButton(_ sender: UIButton) {
        
        handleLoginRegister()
   
    }
    
    
    func handleLoginRegister(){//will switch handle func based on the segmented control view
        if segmentedControl.selectedSegmentIndex == 0 {
            handleLogin()//log back in
        }else {
            handleRegister()//register back on to firebase
        }
    }
    
    
    func handleLogin(){//log back in using email and pass word only
        
        guard let email = emailtextField.text, let password = passwordtextField.text else{
            
            print("Service Unavailable, Please try again")
            return
            
        }
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in  //login with email
            
            if user != nil {
                
               self.performSegue(withIdentifier: "gotoMain", sender: self)
                
                
            }
            else {
                //ERROR: catch handle
                print("login error")
            }
            
            
        })
    }
    
    
    
    
    
    
    func registerUserintoDatabaseWithUID(uid: String, values: [String: AnyObject]){
        
        let ref = FIRDatabase.database().reference()
        let usersReference  = ref.child("Users").child(uid)//create auto ID for child
        
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            if err != nil {
                print(err!)
                return
            }
            
            let user = User()
            //this setter crashes if keys dont match
            
            
            user.setValuesForKeys(values)
            
            self.performSegue(withIdentifier: "gotoMain", sender: self)
            
           
        })
    }
    
    
    func handleRegister(){
        
        guard let email = emailtextField.text, let password = passwordtextField.text, let name = nametextField.text else{
            
            print("Service Unavailable, Please try again")
            return//if all fields not filled out completely, logout
        }
        //firebase authtification access( if not authenticated then throw error)
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            
            guard let uid = user?.uid else {
                return
                
            }
            if user != nil {
                
                let values = ["username": name, "email": email, "password": password]
                self.registerUserintoDatabaseWithUID(uid: uid, values: values as [String : AnyObject])
                
            }
            else {
                print("register error")
                //Error: check error
            }
            //user has been authenticated
        })
        
    }
    
    
    
    
  
    
    


}
