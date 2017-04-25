//
//  ComposeViewController.swift
//  Pair
//
//  Created by Chatan Konda on 3/28/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import FirebaseDatabase
import WebKit
import CoreLocation
import Firebase

class postComposeViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    
    var ref: FIRDatabaseReference?
    
    let locationManager = CLLocationManager()
    var LocCity:String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        ref = FIRDatabase.database().reference()
        
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
       // let newPlace = self.displayLocationInfo(placemark: CLPlacemark)
        
        
        jobType.delegate = self
        jobDescription.delegate = self
        jobPrice.delegate = self
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        jobType.resignFirstResponder()
        jobDescription.resignFirstResponder()
        jobPrice.resignFirstResponder()
    }

//    @IBOutlet weak var jobType: UITextField!//box1
//    @IBOutlet weak var jobDescription: UITextField!//box2
//    @IBOutlet weak var jobPrice: UITextField!//box3
    
    @IBOutlet weak var jobType: UITextField!
    
    @IBOutlet weak var jobDescription: UITextField!
    
    @IBOutlet weak var jobPrice: UITextField!
    
    
    
    
    func textFieldShouldReturn(_ jobType: UITextField) -> Bool {
          self.jobType.resignFirstResponder()
          self.jobDescription.resignFirstResponder()
          self.jobPrice.resignFirstResponder()

     return true
    }

    
    @IBAction func addPost(_ sender: Any) {
        
        let JobType = jobType.text!
        let JobDescription = jobDescription.text!
        let JobPrice = Int(jobPrice.text!)

        
        let postRef =  self.ref?.child("Jobs").childByAutoId()
        let postId = postRef?.key
        
        let date = Date()
        let calendar = Calendar.current
        
        
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let day = calendar.component(.day, from: date)
     // let second = calendar.component(.second, from: <#T##Date#>)
        
        
        let test = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date as Date)
        print(test)
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let stringDate = dateFormatter.string(from: date)

        
        print(stringDate)
    
        let postData = [
            "title": JobType,
            "price": JobPrice!,
            "description": JobDescription,
            "name": AppDelegate.user.username!,
            "postid": postId!,
            "location": "Merced, CA",
            "username": AppDelegate.user.userID!,
            "profileImageUrl": AppDelegate.user.profileImageUrl!,
            "timestamp": stringDate
            ] as [String : Any]
        
        
        postRef?.setValue(postData)
        
        dismiss(animated: true, completion: nil)
    }
    

    
    @IBAction func cancelPost(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
      

}
