//
//  ratingViewController.swift
//  Pair
//
//  Created by Chatan Konda on 4/25/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class ratingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    var ratingRef = FIRDatabase.database().reference().child("Ratings")

    
    var ref: FIRDatabaseReference!
    var ratingData = [Ratings]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let messageQuery = ratingRef.child("userID").queryLimited(toLast:25)
        let ratingQuery = messageQuery.observe(.value, with: { (snapshot) in
            
            if snapshot.childrenCount>0{
                //print(snapshot.)
                self.ratingData.removeAll()
                //print("messages in snapshot")
                for ratings in snapshot.children.allObjects as! [FIRDataSnapshot]{
                    print(snapshot)

                }
                // self.tableView.reloadData()
            }
             self.tableView.reloadData()
            
        })
        
        
        
        
    }

    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ratingCell", for: indexPath) as! RatingTableViewCell
        
        let rating = ratingData[indexPath.row]
        cell.rater.text = rating.rater
        cell.comments.text = rating.comments
        cell.raterValue.text = String(describing: rating.ratingValue)
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratingData.count
    }
 
    



}
