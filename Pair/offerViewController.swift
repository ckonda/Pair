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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "offerCell", for: indexPath) as! OfferTableViewCell
        let offer = offerData[indexPath.row]
       // cell.offerLabel.text = offer.offer
        cell.descriptLabel.text = offer.username
        return cell
    }
    
    




}
