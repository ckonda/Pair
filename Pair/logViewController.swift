//
//  logViewController.swift
//  Pair
//
//  Created by Chatan Konda on 4/10/17.
//  Copyright © 2017 Apple. All rights reserved.


import UIKit
import Firebase
import FirebaseAuth

let defaults: UserDefaults = UserDefaults.standard

class logViewController: UIViewController, UITextFieldDelegate ,  UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profilePicture.isUserInteractionEnabled = true
        profilePicture.addGestureRecognizer(tapGestureRecognizer)

        nametextField.delegate = self
        emailtextField.delegate = self
        passwordtextField.delegate = self
        
        nametextField.isHidden = true
        
   
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
        // Your action
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage
        {
            
            
            // info["UIImagePickerControllerOriginalImage"]
            
            selectedImageFromPicker = editedImage
            //print (editedImage.size)
        } else if let originalImage =
            info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            
            selectedImageFromPicker = originalImage
            //print(originalImage.size)
            
        }
        
        if let selectedImage = selectedImageFromPicker
        {
            profilePicture.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
        
        //print(info)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled picker")
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var profilePicture: UIImageView!
    
       var postController: postViewController?

    @IBOutlet weak var segmentedControl: UISegmentedControl!

    @IBAction func segmentedSelect(_ sender: UISegmentedControl) {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            signinButton.setTitle("Sign in", for: .normal)
            nametextField.isHidden = true
            
            handleLoginRegister()

        }else {
            
            nametextField.isHidden = false
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
                    
                   // AppDelegate.user.initialize(username: self.nametextField.text, email: self.emailtextField.text, password: self.passwordtextField.text, userID: userID, profileImageUrl: profileImageUrl )
                    
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
            
            // if user != nil {
            
            let imageName = NSUUID().uuidString
            let storageRef = FIRStorage.storage().reference().child("\(imageName).png")
            
            let profileImage = self.profilePicture.image!
            
            
            if let uploadData = UIImagePNGRepresentation(profileImage){
                
                storageRef.put(uploadData, metadata: nil, completion: {(metadata, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    
                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString{
                        
                                
                        let values = ["username": name, "email": email, "password": password, "userID": uid, "profileImageUrl": profileImageUrl]
                        
                        AppDelegate.user.initialize(username: name, email: self.emailtextField.text, password: self.passwordtextField.text, userID: uid, profileImageUrl: profileImageUrl)
                        
                        
                        self.registerUserintoDatabaseWithUID(uid: uid, values: values as [String : AnyObject])
                        
                        defaults.setValuesForKeys(values)
                        
                        
                    }
                    
                    
                })
                // }
                
                //  AppDelegate.user.initialize(username: nil, email: self.emailtextField.text, password: self.passwordtextField.text, userID: uid, profileImageURL: profileImageUrl )
                
            }
            else {
                print("register error")
                //Error: check error
            }
            //user has been authenticated
        })
        
    }


    
    
  
    
    


}
