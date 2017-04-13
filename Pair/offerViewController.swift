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

    var ref: FIRDatabaseReference!
    var dbHandle: FIRDatabaseHandle?
    var offerData = [OfferModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        ref = FIRDatabase.database().reference().child("Offer");
        ref.observe(FIRDataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.offerData.removeAll()
                for offer in snapshot.children.allObjects as![FIRDataSnapshot]{
                    //create object and initialize the values of it
                    let offer = offer.value as? [String: AnyObject]
                    let offerTitle = offer?["title"]
                    let offerPrice = offer?["price"]
                    let offerUsername = offer?["username"]
                    let offerDescription = offer?["description"]
                   // let jobSkill = job?["skill"]
                    let offerObject = OfferModel(offer: offerTitle as! String?, price: offerPrice as! Int?,username: offerUsername as! String? , description: offerDescription as! String?)
                    //append data
                    self.offerData.append(offerObject)
                }
                self.tableView.reloadData()
            }
        })
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offerData.count
    }
    
    var bidpassUsername: String!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "offerCell", for: indexPath) as! OfferTableViewCell
        let offer = offerData[indexPath.row]
       // cell.offerLabel.text = offer.offer
        cell.descriptLabel.text = offer.username
        
        bidpassUsername = offer.username//for passing to bid
        
        
        
        return cell
    }
    
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          print("You selected cell #\(indexPath.row)!")
        
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        
        performSegue(withIdentifier: "offerBid", sender: self)
        

    }

    
     func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
    
        
        if (segue.identifier == "offerBid") {
            // initialize new view controller and cast it as your view controller
            var offerbidView = segue.destination as! offerBidViewController
            
            
            offerbidView.offerName = bidpassUsername
            
            
            
         
        }
    }
    
    




}
