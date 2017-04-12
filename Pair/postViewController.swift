//
//  postViewController.swift
//  Pair
//
//  Created by Chatan Konda on 4/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class postViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref: FIRDatabaseReference!
    var dbHandle: FIRDatabaseHandle?
    var jobData = [JobModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        ref = FIRDatabase.database().reference().child("Jobs");
        ref.observe(FIRDataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.jobData.removeAll()
                for jobs in snapshot.children.allObjects as![FIRDataSnapshot]{
                    //create object and initialize the values of it
                    let job = jobs.value as? [String: AnyObject]
                    let jobTitle = job?["title"]
                    let jobPrice = job?["price"]
                    let jobUsername = job?["username"]
                    let jobSkill = job?["skill"]
                    let jobObject = JobModel(job: jobTitle as! String?, price: jobPrice as! Int?, skill: jobSkill as! String?, username: jobUsername as! String?)
                    //append data
                    self.jobData.append(jobObject)
                }
                self.tableView.reloadData()
            }
        })
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath) as! JobsTableViewCell
        let job = jobData[indexPath.row]
        cell.postLabel.text = job.job
        cell.descriptionLabel.text = job.username
        return cell
    }
    
    
    
    
    
  

}
