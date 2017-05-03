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
        
        let messageQuery = ratingRef.child(AppDelegate.user.userID!).queryLimited(toLast:25)
        let ratingQuery = messageQuery.observe(.value, with: { (snapshot) in
            
            if snapshot.childrenCount>0{
                //print(snapshot.)
                self.ratingData.removeAll()
                //print("messages in snapshot")
                for ratings in snapshot.children.allObjects as! [FIRDataSnapshot]{
                    print(ratings)
                    var rating = ratings.value as! [String:Any?]
                    let comment = rating["comments"]
                    let rater = rating["rater"]
                    let rate = rating["ratingValue"]
                    let raterID = rating["raterid"]
                    
                    let ratingValues = Ratings(comments: comment as! String?, rater: rater as! String?, ratingValue: rate as! Int?, raterID: raterID as! String!)
                    self.ratingData.insert(ratingValues, at: 0)

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
        
        
        let nameIDPath = FIRDatabase.database().reference().child("Users").child(rating.raterID!)
        nameIDPath.observeSingleEvent(of: .value, with: { (snapshot) in
            print("here")
            print(snapshot)
            print("here2")

            let userInfo = snapshot.value as! [String: Any]
          //  cell.senderName.text = (nameJSON["username"] as! String?)!
            
            print(userInfo)
            
            if let profileImage = userInfo["profileImageUrl"] as! String? {
    
                  cell.raterPicture.loadImageUsingCacheWithUrlString(urlString: profileImage)
//                let url = URL(string: profileImage)
//                print("before")
//                URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
//                    if error != nil{
//                        print(error!)//download hit error so return out
//                    }
//                    DispatchQueue.main.async(execute: {
//                        cell.raterPicture.image = UIImage(data: data!)
//                    })
//                }).resume()
            }
            
        })
        
        
        
        cell.rater.text = rating.rater
        cell.comments.text = rating.comments
       // cell.raterValue.text = String(describing: rating.ratingValue!)
        
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
            if ratingControl == 5 {
                cell.dot1.image = fulldot
                cell.dot2.image = fulldot
                cell.dot3.image = fulldot
                cell.dot4.image = fulldot
                cell.dot5.image = fulldot
            }
            
        }
        
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ratingData.count
    }
 
    



}
