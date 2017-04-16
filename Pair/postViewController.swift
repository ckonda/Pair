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
    
    
    
    /*if revealViewController() != nil {
        openMenu.target
    }*/
    //openMenu.target = revealViewController()
    @IBOutlet weak var openMenu: UIBarButtonItem!
    
    var ref: FIRDatabaseReference!
    var dbHandle: FIRDatabaseHandle?
    var jobData = [JobModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
                //openMenu.target = self.revealViewController()
        //openMenu.action = Selector("revealToggle:")
        
        tableView.delegate = self
        tableView.dataSource = self
        ref = FIRDatabase.database().reference().child("Jobs");
        ref.observe(FIRDataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.jobData.removeAll()
                for jobs in snapshot.children.allObjects as![FIRDataSnapshot]{
                    //create object and initialize the values of it
                    let job = jobs.value as? [String: AnyObject]
                    let jobTitle = job?["title"] as! String?//job type
                    let jobPrice = job?["price"] as! Int?//job price
                    let jobUsername = job?["username"] as! String?// username
                    //let jobSkill = job?["skill"]
                    let jobDescription = job?["description"] as! String?// job description
                    let jobObject = JobModel(job: jobTitle , price: jobPrice ,  username: jobUsername , description: jobDescription )
                    //append data
                    self.jobData.append(jobObject)
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
