//
//  offerViewController.swift
//  Pair
//
//  Created by Chatan Konda on 4/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class offerViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var openMenu: UIBarButtonItem!
    var ref: FIRDatabaseReference!
    var dbHandle: FIRDatabaseHandle?
    var offerData = [OfferModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        ref = FIRDatabase.database().reference().child("Offers");
        ref.observe(FIRDataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.offerData.removeAll()
                for offer in snapshot.children.allObjects as![FIRDataSnapshot]{
                    //create object and initialize the values of it
                    let offer = offer.value as? [String: AnyObject]
                    
                    let offerTitle = offer?["offer"] as! String?
                    let offerPrice = offer?["price"] as! Int?
                    let offerUsername = offer?["username"]as! String?
                    let offerSkill = offer?["skill"]as! String?
                    let offerId = offer?["offerid"] as! String?
                    let offerImage = offer?["profileImageUrl"] as! String?
                    let name = offer?["name"] as! String?
                    let location = offer?["location"] as! String?
                    let timestamp = offer?["timestamp"] as! String?
                    
                    let offerObject = OfferModel(offerName: offerTitle, price: offerPrice, username: offerUsername, skill: offerSkill, offerid: offerId, profileImageUrl: offerImage, location: location, name: name, timestamp: timestamp)
                    
                    //append data
                    
                    //  self.offerData.append(offerObject)
                    self.offerData.insert(offerObject, at: 0)
                }
                
                self.tableView.reloadData()
            }
        })
        
        if revealViewController() != nil{
            openMenu.target = revealViewController()
            openMenu.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offerData.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "offerCell", for: indexPath) as! OfferTableViewCell
        let offer = offerData[indexPath.row]
        
        //        cell.offerLabel.text = offer.offer
        //        cell.offerPrice.text = String(describing: offer.price!)
        
        
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = tableView.indexPathForSelectedRow?.row
        
        performSegue(withIdentifier: "offerBid", sender: index)
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        
        if (segue.identifier == "offerBid") {
            // initialize new view controller and cast it as your view controller
            
            
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let offerbidView = segue.destination as? offerBidViewController
                
                offerbidView?.selecteduserName = offerData[indexPath.row].username!
                offerbidView?.selectedSkill = offerData[indexPath.row].skill!
                
            }
        }
    }
    
    
    
}
