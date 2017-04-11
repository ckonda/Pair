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
                for jobs in snapshot.children.allObjects as![FIRDataSnapshot]{
                    //create object and initialize the values of it
                    let job = jobs.value as? [String: AnyObject]
                    let jobTitle = job?["title"]
                    let jobPrice = job?["price"]
                    let jobUsername = job?["username"]
                    let jobSkill = job?["skill"]
                    let jobObject = OfferModel(job: jobTitle as! String?, price: jobPrice as! Int?, skill: jobSkill as! String?, username: jobUsername as! String?)
                    //append data
                    self.offerData.append(jobObject)
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
        let job = offerData[indexPath.row]
        cell.offerLabel.text = job.job
        cell.descriptionLabel.text = job.username
        return cell
    }
    
    




}
