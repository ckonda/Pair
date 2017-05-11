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

class postViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var openMenu: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var ref: FIRDatabaseReference!
    var dbHandle: FIRDatabaseHandle?
    var jobData = [JobModel]()
    
    var filteredData = [JobModel]()
    var isSearching = false
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.resignFirstResponder()
        
        return true
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done

        
        searchBar.placeholder = "Search"
        
        
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
                    let location = job?["location"] as! String
                    let timestamp = job?["timestamp"] as! String?
                    
                    let jobObject = JobModel(jobName: jobTitle , price: jobPrice , username: jobUsername , description: jobDescription , postid: jobId, profileImageUrl: jobImage, location: location, name: name, timestamp: timestamp )
  
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
        
        if isSearching
        {
            return filteredData.count
        }
        
        return jobData.count
    }
    
    
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath) as! JobsTableViewCell
        
        let job:JobModel
        if isSearching {
            print("\(filteredData.count)")
            job = filteredData[indexPath.row]
            cell.postLabel.text = job.jobName
            cell.postPrice.text = String(describing: job.price!)
            cell.locationLabel.text = job.location
        }
        else{
            print("\(filteredData.count)")
            job = jobData[indexPath.row]
            cell.postLabel.text = job.jobName
            cell.postPrice.text = String(describing: job.price!)
            cell.locationLabel.text = job.location
        }
        
        
        
        
        
        let time = job.timestamp
//        
        let dateString = time
        let dateformatter = DateFormatter()
//        dateformatter.dateFormat = "dd-MM-yyyy"// HH:mm:ss"
        dateformatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        dateformatter.timeZone = NSTimeZone(abbreviation: "PT+0:00") as TimeZone!
        let dateFromString = dateformatter.date(from: dateString!)
        
        
        let timeAgo:String = timeAgoSinceDate((dateFromString)!, numericDates: true)
        cell.timestamp.text = timeAgo
        
        let text: String!
        let text1: String!
        let text2: String!
        let text3: String!
        let text4: String!
        let text5: String!
        let text6: String!
        
        
        let number: Int!
        if isSearching {
            if searchBar.text! == job.jobName {
                filteredData.append(job)
       
           
            }
            
        }
        else
        {
            text = jobData[indexPath.row].jobName
            print("entered else -> \(text)")
            
        }
        
  
    
        if let profileImage = job.profileImageUrl {
            
            
            cell.profilePicture.loadImageUsingCacheWithUrlString(urlString: profileImage)

            
        }


        return cell
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text == nil || searchBar.text == "") {
            
            isSearching = false
            
            view.endEditing(true)
            print ("working")
            tableView.reloadData()
            
        }
            
        else
        {
            isSearching = true
            //print({$0.jobName)
            
            //filteredData.append(
            filteredData = jobData.filter({($0.jobName?.localizedCaseInsensitiveContains(searchBar.text!))!})
            print("filtered data = \(filteredData.count)")
            if filteredData.count == 1 {
                print("filtered data [0] = \(filteredData[0].jobName)")
            }
            if filteredData.count == 2 {
                print("filtered data [0] = \(filteredData[0].jobName)")
                print("filtered data [1] = \(filteredData[1].jobName)")
            }
            //jobData = filteredData
            print("working2")
            tableView.reloadData()
            print("reloaded")
            
        }
    }
    

    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = tableView.indexPathForSelectedRow?.row
        
        
        performSegue(withIdentifier: "gotoBid", sender: index)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            if (segue.identifier == "gotoBid") {
                // initialize new view controller and cast it as your view controller
                if let indexPath = self.tableView.indexPathForSelectedRow{
                    let postbidView = segue.destination as? postBidViewController
                    
                    postbidView?.selectedName = jobData[indexPath.row].jobName!
                    postbidView?.selectedDescription = jobData[indexPath.row].description!
                    postbidView?.selectedID = jobData[indexPath.row].postid!
                    
                    postbidView?.bidpictureUrl = jobData[indexPath.row].profileImageUrl!
                    
                    postbidView?.toID = jobData[indexPath.row].username!
                    postbidView?.name = jobData[indexPath.row].name!
                    
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
    
    
    
    

    func timeAgoSinceDate(_ date:Date, numericDates:Bool = false) -> String {
        let calendar = Calendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = Date()
        let earliest = now < date ? now : date
        let latest = (earliest == now) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest)
        
        if (components.year! >= 2) {
            return "\(components.year!) years ago"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!) months ago"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1 month ago"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks ago"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) days ago"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) hours ago"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) minutes ago"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!) seconds ago"
        } else {
            return "Just now"
        }
        
    }




}
