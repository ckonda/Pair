//
//  logViewController.swift
//  Pair
//
//  Created by Chatan Konda on 4/10/17.
//  Copyright © 2017 Apple. All rights reserved.


import UIKit
import Firebase
import FirebaseAuth

class logViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        nametextField.delegate = self
        emailtextField.delegate = self
        passwordtextField.delegate = self
        
   
    }
    
       var postController: postViewController?

    @IBOutlet weak var segmentedControl: UISegmentedControl!

    @IBAction func segmentedSelect(_ sender: UISegmentedControl) {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            signinButton.setTitle("Sign in", for: .normal)
            handleLoginRegister()

        }else {
            signinButton.setTitle("Join", for: .normal)
            handleLoginRegister()

        }
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nametextField.resignFirstResponder()
        emailtextField.resignFirstResponder()
        passwordtextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nametextField.resignFirstResponder()
        emailtextField.resignFirstResponder()
        passwordtextField.resignFirstResponder()
        
        return true
        
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
        
        var FBRef: FIRDatabaseReference!
        
        FBRef = FIRDatabase.database().reference();
        
        guard let email = emailtextField.text, let password = passwordtextField.text else{
            
            print("Service Unavailable, Please try again")
            return
            
        }
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in  //login with email
    
            
            if user != nil {
                
                
                let userID: String = (FIRAuth.auth()?.currentUser?.uid)!
                
                
                FBRef.child("Users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                    let dict = snapshot.value as? NSDictionary
                    let username = dict?["username"] as? String!
                    
                    AppDelegate.user.initialize(username: self.nametextField.text, email: self.emailtextField.text, password: self.passwordtextField.text, userID: userID )
                    
                    AppDelegate.user.username = username
                       self.performSegue(withIdentifier: "gotoMain", sender: self)
                })
            }
            else {
                //ERROR: catch handle
                print("login error")
            }
        })
        
  
        
        //self.performSegue(withIdentifier: "gotoMain", sender: self)
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
            
            
      //  AppDelegate.user.initialize(username: nil, email: self.emailtextField.text, password: self.passwordtextField.text, userID: uid)

            user.setValuesForKeys(values)
        
            self.performSegue(withIdentifier: "gotoMain", sender: self)
        })
    }
    
    
    
    func handleRegister(){
        print("1")
        
        guard let email = emailtextField.text, let password = passwordtextField.text, let name = nametextField.text else{
            
            print("Service Unavailable, Please try again")
            return//if all fields not filled out completely, logout
        }
        //firebase authtification access( if not authenticated then throw error)
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            
            print("2")
            
            guard let uid = user?.uid else {
                return
            }
            
            if user != nil {
                
                print("3")
                let values = ["username": name, "email": email, "password": password, "userID": uid]
                
                AppDelegate.user.initialize(username: nil, email: self.emailtextField.text, password: self.passwordtextField.text, userID: uid)
                
                //print(uid)
                
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
