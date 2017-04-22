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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        //handleLogout()
        //self.tableView.reloadData()
        //animateTable()
    }
    
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
                    let jobTitle = job?["title"] as! String?//job type
                    let jobPrice = job?["price"] as! Int?//job price
                    let jobUsername = job?["username"] as! String?// username
                    //let jobSkill = job?["skill"]
                    let jobDescription = job?["description"] as! String?// job description
                    let jobId = job?["postid"] as! String?
                    let jobImage = job?["profileImageUrl"] as! String?
                    let name = job?["name"] as! String?
                    let location = job?["location"] as! String?
                    
                  let jobObject = JobModel(jobName: jobTitle , price: jobPrice , username: jobUsername , description: jobDescription , postid: jobId,profileImageUrl: jobImage ,location: location, name: name)
                    //append data
                   // self.jobData.append(jobObject)
                    
                           self.jobData.insert(jobObject, at: 0)
                }
              // self.tableView.reloadData()
      
             self.animateTable()//animate in progress
                
                
                
                

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
        cell.postLabel.text = job.jobName
        cell.postPrice.text = String(describing: job.price!)
        cell.locationLabel.text = job.location
        
        
        if let profileImage = job.profileImageUrl {
            
            let url = URL(string: profileImage)
            print("before")
            
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if error != nil{
                    print(error!)//download hit error so return out
                }
                
                DispatchQueue.main.async(execute: {
                
                    cell.profilePic.image = UIImage(data: data!)
                    
                    
                })
                
                
            }).resume()
        }

        
        
        
        
        
        
        
        

       // cell.descriptionLabel.text = job.username
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = tableView.indexPathForSelectedRow?.row
        performSegue(withIdentifier: "gotoBid", sender: index)
        
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            if (segue.identifier == "gotoBid") {
                // initialize new view controller and cast it as your view controller
                if let indexPath = self.tableView.indexPathForSelectedRow{
                    let postbidView = segue.destination as? postBidViewController
                    
                    postbidView?.selectedName = jobData[indexPath.row].jobName!
                    postbidView?.selectedDescription = jobData[indexPath.row].description!
                    postbidView?.selectedID = jobData[indexPath.row].postid!
                    
                    postbidView?.toID = jobData[indexPath.row].username!
                }
            }
    }
  
    
    
    func animateTable(){
        tableView.reloadData()
        let cells = tableView.visibleCells//each individual cells size in cells
        
        let tableViewHeight = tableView.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        var delayNum = 0//count the time delayed in animation
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay: Double(delayNum) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
                
            }, completion: nil)
            delayNum += 1
        }
    }
    
    
    
//    func handleLogout(){
//        
//        do {
//            try FIRAuth.auth()?.signOut() //handles registration screen if user is not logged
//        }catch let logoutError {//keeps them logged in
//            print(logoutError)
//        }
//        
////        let loginController = logViewController()
////        loginController.postController = self
////        
////        present(loginController, animated: true, completion: nil)//logout controller animation
////        
//    }
    
    
    
    



}
