//
//  offerbidRatingViewController.swift
//  Pair
//
//  Created by Chatan Konda on 5/9/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class offerbidRatingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    var ratingRef = FIRDatabase.database().reference().child("Ratings")
    var ref: FIRDatabaseReference!
    
    
    
    
    var offerbidRatingData = [offerbidderRatings]()
    public var Name = String()
    
    public var profilepictureUrl = String()
    
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var profileName: UILabel!
    

    
    var postuserID:String? //person you're rating
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        profileName.text = Name
        
        FIRStorage.storage().reference(forURL: profilepictureUrl).data(withMaxSize: 25 * 1024 * 1024) { (data, error) in
            self.profilePicture.loadImageUsingCacheWithUrlString(urlString: self.profilepictureUrl)
        }
        
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2
        profilePicture.clipsToBounds = true
        profilePicture.layer.borderColor = UIColor.white.cgColor
        profilePicture.layer.borderWidth = 1
        
        
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let messageQuery = ratingRef.child(postuserID!).queryLimited(toLast:25)
        let ratingQuery = messageQuery.observe(.value, with: { (snapshot) in
            
            if snapshot.childrenCount>0{
                //print(snapshot.)
                self.offerbidRatingData.removeAll()
                //print("messages in snapshot")
                for ratings in snapshot.children.allObjects as! [FIRDataSnapshot]{
                    print(ratings)
                    var rating = ratings.value as! [String:Any?]
                    let comment = rating["comments"]
                    let rater = rating["rater"]
                    let rate = rating["ratingValue"]
                    let raterID = rating["raterid"]
                    
                    let ratingValues = offerbidderRatings(comments: comment as! String?, rater: rater as! String?, ratingValue: rate as! Int?, raterID: raterID as! String?)
                    self.offerbidRatingData.insert(ratingValues, at: 0)
                    
                }
                // self.tableView.reloadData()
            }
            self.tableView.reloadData()
            
        })
        
        
        
        
    }
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
   
    @IBAction func backButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "bidRateCell", for: indexPath) as! bidRatingTableViewCell
        
        let rating = offerbidRatingData[indexPath.row]
        
        
        let nameIDPath = FIRDatabase.database().reference().child("Users").child(rating.raterID!)
        nameIDPath.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let userInfo = snapshot.value as! [String: Any]
      
            if let profileImage = userInfo["profileImageUrl"] as! String? {
                
                
                cell.raterPicture.loadImageUsingCacheWithUrlString(urlString: profileImage)
                
            }
            
        })
        
        
        let testVar = rating.ratingValue
        let fulldot: UIImage = UIImage(named: "oneDot")!
        
        if let ratingControl = testVar{
            if ratingControl == 1{
                cell.dot1.image = fulldot
            }
            if ratingControl == 2{
                cell.dot1.image = fulldot
                cell.dot2.image = fulldot
            }
            if ratingControl == 3{
                cell.dot1.image = fulldot
                cell.dot2.image = fulldot
                cell.dot3.image = fulldot
                
            }
            if ratingControl == 4{
                cell.dot1.image = fulldot
                cell.dot2.image = fulldot
                cell.dot3.image = fulldot
                cell.dot4.image = fulldot
                
            }
            if ratingControl >= 5 {
                cell.dot1.image = fulldot
                cell.dot2.image = fulldot
                cell.dot3.image = fulldot
                cell.dot4.image = fulldot
                cell.dot5.image = fulldot
            }
            
        }
        
        
        
        
        cell.rater.text = rating.rater
        cell.comments.text = rating.comments
       
        
        return cell
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offerbidRatingData.count
    }
    
    

}
