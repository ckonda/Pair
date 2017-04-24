//
//  pendingViewController.swift
//  Pair
//
//  Created by Chatan Konda on 4/23/17.
//  Copyright © 2017 Apple. All rights reserved.
//


import UIKit
import Firebase
import FirebaseDatabase

class pendingViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    var bidData = [pastBids]()

    
    var ref: FIRDatabaseReference!
    
    @IBAction func cancel(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
   

    

    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        ref = FIRDatabase.database().reference().child("Bids");
        
        //tableView.delegate = self
        //tableView.dataSource = self
        //ref = FIRDatabase.database().reference().child("Jobs");
        ref.observe(FIRDataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.bidData.removeAll()
                for bids in snapshot.children.allObjects as![FIRDataSnapshot]{
                    //create object and initialize the values of it
                    let bid = bids.value as? [String: AnyObject]
                    let biderID = bid?["bidderID"] as! String?//job type
                    let ownerID = bid?["ownerID"] as! String?//job price
                    let postID = bid?["postID"] as! String?// username
                    //let jobSkill = job?["skill"]
                    let postPrice = bid?["postPrice"] as! Int?
                    let timeStamp = bid?["timestamp"] as! String?// job description
                    
                    //self.postPrice = postPrice
                    //self.postID = postID
                    //self.bidderID = bidderID
                    //self.ownerID = ownerID
                    
                
                    let bidObject = pastBids(postPrice: postPrice , postID: postID , bidderID: biderID , ownerID: ownerID! , timeStamp: timeStamp!)
                    //append data
                     self.bidData.append(bidObject)
                    print(snapshot)
                
                    //self.bidData.insert(bidObject, at: 0)
                }
            }
            print(self.bidData.count)
            self.tableView.reloadData()
        })


        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pastbidCell", for: indexPath) as! pendingBidCell
        
        let bid = bidData[indexPath.row]
        
        cell.timeStamp.text = bid.timeStamp
        print("timestamp = \(cell.timeStamp.text)")
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("dkljfosdjf: \(bidData.count)")
        
        
        return bidData.count
    }
    
    
   
    
    
    
    
    
}
