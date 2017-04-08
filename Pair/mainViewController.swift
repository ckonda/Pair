//
//  mainViewController.swift
//  Pair
//
//  Created by Chatan Konda on 3/28/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Firebase

class mainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var jobData = ["Job1","Job2", "Job3","Job4"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        
    }
    
    @IBOutlet weak var tableView: UITableView!


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell")
        cell?.textLabel?.text = jobData[indexPath.row]
        
        return cell!
    }
    
    



}
