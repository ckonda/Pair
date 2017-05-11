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
import FirebaseStorage



class postBidViewController: UIViewController, UITextFieldDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jobName.text = selectedName
        jobDescription.text = selectedDescription
        bidEnter.delegate = self
        posterName.text = name//name for the user on bid
        
        
        bidEnter.keyboardType = UIKeyboardType.numberPad
        
        FIRStorage.storage().reference(forURL: bidpictureUrl).data(withMaxSize: 25 * 1024 * 1024) { (data, error) in
            self.bidprofilePicture.loadImageUsingCacheWithUrlString(urlString: self.bidpictureUrl)
        }

        bidprofilePicture.layer.cornerRadius = bidprofilePicture.frame.size.width/2
        bidprofilePicture.clipsToBounds = true
        bidprofilePicture.layer.borderColor = UIColor.white.cgColor
        bidprofilePicture.layer.borderWidth = 1
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        
        bidprofilePicture.isUserInteractionEnabled = true
        bidprofilePicture.addGestureRecognizer(tapGestureRecognizer)
        
        
    }
    
    
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        

        performSegue(withIdentifier: "toPosterRating", sender: self)
        
        // Your action
    }
    
    
//    let picker = UIImagePickerController()
//    picker.delegate = self
//    picker.allowsEditing = true
//    present(picker, animated: true, completion: nil)

    
    
    
    
    
    
    
    
    @IBOutlet weak var bidprofilePicture: UIImageView!
    
    
    
    var ref: FIRDatabaseReference!
    
    public var postID = String()
    
    
    
    public var selectedName = String()
    public var selectedDescription = String()
    public var selectedPrice = Int()
    public var selectedID = String()//the ID for the current post
    
    public var name = String()
    public var toID = String()
    
    public var bidpictureUrl = String()//Post Owners picture to appear
    
    
    @IBOutlet weak var posterName: UILabel!
    
    @IBOutlet weak var cancelPost: UIBarButtonItem!
    
    @IBOutlet weak var jobName: UILabel!
    
    @IBOutlet weak var jobDescription: UILabel!
    
    @IBOutlet weak var bidEnter: UITextField!
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        bidEnter.resignFirstResponder()
      
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        bidEnter.resignFirstResponder()

        return true
        
    }
    
    
    

    
    
    
    
    @IBAction func ratingsButton(_ sender: Any) {
        
        performSegue(withIdentifier: "toPosterRating", sender: self)
        
    }//segue to ratings
    
    
    
    
    
    

    @IBAction func cancelView(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    var messageexample = "hello"
    
    
    @IBAction func bidButton(_ sender: Any) {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let stringDate = dateFormatter.string(from: date)
        
        if let text = bidEnter.text {//String to variable
            guard let bid = Int(text) else {//variable to integers to BID
                // return bid
                return
            }
            let newPrice = bid
  
            
            let bidRef = FIRDatabase.database().reference().child("Bids")
            let bidCreate = bidRef.childByAutoId()
         //   let newKey = bidCreate?.key//key for message ID
            
          
            
            
            let postBid = [
                "bidderID": AppDelegate.user.userID!,
                "ownerID": toID,
                "postID": selectedID,
                "postPrice": newPrice,
                "timestamp": stringDate,
                "name": AppDelegate.user.username!,
                "description": selectedName,
                ] as [String : Any]
     
            bidCreate.setValue(postBid)
            

        }
        
        
        dismiss(animated: true, completion: nil)
        
        
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toPosterRating"){
            
            let destination = segue.destination as! postbidRatingViewController
            destination.postuserID = toID
            destination.Name = name
            destination.profilepictureUrl = bidpictureUrl
            
            
            

        }
        
    }

    
    
    
    

    
    
    



}
