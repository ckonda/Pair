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
                    let name = bid?["name"] as!  String?
                    let Description = bid?["description"] as! String?
                    
                    let bidObject = pastBids(postPrice: postPrice , postID: postID , bidderID: biderID , ownerID: ownerID! , timeStamp: timeStamp!, Description: Description, name: name)
                    //append data
                    self.bidData.insert(bidObject, at: 0)
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
        cell.price.text = String(describing: bid.postPrice!)
        cell.bidder.text = bid.name
        cell.Description.text = bid.Description
        
        let nameIDPath = FIRDatabase.database().reference().child("Users").child(bid.bidderID!)
        nameIDPath.observeSingleEvent(of: .value, with: { (snapshot) in
            let pendingPicture = snapshot.value as! [String: Any]
            
            if let profileImage = pendingPicture["profileImageUrl"] as! String? {
                
                let url = URL(string: profileImage)
                print("before")
                URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                    if error != nil{
                        print(error!)//download hit error so return out
                    }
                    DispatchQueue.main.async(execute: {
                        cell.pendingPicture.image = UIImage(data: data!)
                    })
                }).resume()
            }
            
        })
        
        
        let time = bid.timeStamp
        //
        let dateString = time
        let dateformatter = DateFormatter()
        //        dateformatter.dateFormat = "dd-MM-yyyy"// HH:mm:ss"
        dateformatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        dateformatter.timeZone = NSTimeZone(abbreviation: "PT+0:00") as TimeZone!
        let dateFromString = dateformatter.date(from: dateString!)
        
        
        let timeAgo:String = timeAgoSinceDate((dateFromString)!, numericDates: true)
        cell.timeStamp.text = timeAgo
        
        
        
        
        
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("dkljfosdjf: \(bidData.count)")
        
        
        return bidData.count
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            bidData.remove(at: indexPath.row)
            tableView.reloadData()
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
