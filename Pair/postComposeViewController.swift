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
        
        let postData = [
            "title": JobType,
            "price": JobPrice!,
            "description": JobDescription,
            "name": UserDefaults.standard.object(forKey: "username")!,
            "postid": postId!,
            "location": "Merced, CA",
            "username": UserDefaults.standard.object(forKey: "userID")!,
            "profileImageUrl": UserDefaults.standard.object(forKey: "profileImageUrl")!
            ] as [String : Any]
        
        
        postRef?.setValue(postData)
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    @IBAction func cancelPost(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    

    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: { (placemarks, error) in
            if error != nil
            {
                print("Error: " + "(error?.localizedDescription)")
                return
            }
            if (placemarks?.count)! > 0
            {
                let pm = placemarks?[0]
                self.displayLocationInfo(placemark: pm!)
            }
        })
    }
    

    
    func displayLocationInfo(placemark: CLPlacemark) -> String
    {
        self.locationManager.stopUpdatingLocation()
        print(placemark.locality!)
        print(placemark.postalCode!)
        print(placemark.administrativeArea!)
        print(placemark.country!)
        
        let location = placemark.country
        
        return location!
    }
    

    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: " + error.localizedDescription)
        
    }
    
    

}
