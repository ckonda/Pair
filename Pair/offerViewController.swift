//
//  offerViewController.swift
//  Pair
//
//  Created by Chatan Konda on 4/11/17.
//  Copyright © 2017 Apple. All rights reserved.


import UIKit
import Firebase
import FirebaseAuth

class offerViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var openMenu: UIBarButtonItem!
    var ref: FIRDatabaseReference!
    var dbHandle: FIRDatabaseHandle?
    var offerData = [OfferModel]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var filteredData = [OfferModel]()
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
        ref = FIRDatabase.database().reference().child("Offers");
        ref.observe(FIRDataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.offerData.removeAll()
                for offer in snapshot.children.allObjects as![FIRDataSnapshot]{
                    //create object and initialize the values of it
                    let offer = offer.value as? [String: AnyObject]
                    
                    let offerTitle = offer?["title"] as! String?
                    let offerPrice = offer?["price"] as! Int?
                    let offerUsername = offer?["username"]as! String?
                    let offerSkill = offer?["description"]as! String?
                    let offerId = offer?["postid"] as! String?
                    let offerImage = offer?["profileImageUrl"] as! String?
                    let name = offer?["name"] as! String?
                    let location = offer?["location"] as! String?
                    let timestamp = offer?["timestamp"] as! String?
                    
                    let offerObject = OfferModel(offerName: offerTitle, price: offerPrice, username: offerUsername, skill: offerSkill, offerid: offerId, profileImageUrl: offerImage, location: location, name: name, timestamp: timestamp)

                    self.offerData.insert(offerObject, at: 0)
                }
                
                //self.tableView.reloadData()
                
                self.animateTable()
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
        
        return offerData.count
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "offerCell", for: indexPath) as! OfferTableViewCell
        
        
        let offer:OfferModel
        if isSearching {
          
            offer = filteredData[indexPath.row]
            cell.offerLabel.text = offer.offerName
            cell.offerPrice.text = String(describing: offer.price!)
            cell.locationLabel.text = offer.location
        }
        else{
   
            offer = offerData[indexPath.row]
            cell.offerLabel.text = offer.offerName
            cell.offerPrice.text = String(describing: offer.price!)
            cell.locationLabel.text = offer.location
        }
        
        

        
        let time = offer.timestamp
        //
        let dateString = time
        let dateformatter = DateFormatter()

        dateformatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        dateformatter.timeZone = NSTimeZone(abbreviation: "PT+0:00") as TimeZone!
        let dateFromString = dateformatter.date(from: dateString!)
        
        
        let timeAgo:String = timeAgoSinceDate((dateFromString)!, numericDates: true)
        cell.timestamp.text = timeAgo
        
        
        if isSearching {
            if searchBar.text! == offer.offerName {
                filteredData.append(offer)
                
          
            }
            
        }
        else
        {
     
            
        }
        
        
        
        
        
        
        
        
        if let profileImage = offer.profileImageUrl {
            
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
            //filteredData = offerData.filter({$0.offerName == searchBar.text!})
            
            filteredData = offerData.filter({($0.offerName?.localizedCaseInsensitiveContains(searchBar.text!))!})
            
            
            print("filtered data = \(filteredData.count)")
            if filteredData.count == 1 {
  
            }
            if filteredData.count == 2 {
            
            }
            //jobData = filteredData
            print("working2")
            tableView.reloadData()
            print("reloaded")
            
        }
    }
    

    
    
    
    
    

    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        let index = tableView.indexPathForSelectedRow?.row
        
        performSegue(withIdentifier: "offerBid", sender: index)
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    

    
      override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
    
        if (segue.identifier == "offerBid") {
            // initialize new view controller and cast it as your view controller
                
                
                if let indexPath = self.tableView.indexPathForSelectedRow{
                    let offerbidView = segue.destination as? offerBidViewController
            
                 
                    offerbidView?.selectedName = offerData[indexPath.row].offerName!
                    offerbidView?.selectedSkill = offerData[indexPath.row].skill!
                    offerbidView?.selectedID = offerData[indexPath.row].offerid!
                    offerbidView?.toID = offerData[indexPath.row].username!
                    
                    
                    offerbidView?.name = offerData[indexPath.row].name!
                    offerbidView?.bidpictureUrl = offerData[indexPath.row].profileImageUrl!
                    
                    
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
