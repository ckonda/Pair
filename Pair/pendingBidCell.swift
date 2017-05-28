//
//  pendingBidCell.swift
//  Pair
//
//  Created by Chatan Konda on 4/23/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase


public class pendingBidCell: UITableViewCell {
    
    @IBOutlet weak var pendingPicture: UIImageView!
    
    var ref: FIRDatabaseReference!
    
    @IBOutlet weak var timeStamp: UILabel!
    
    @IBOutlet weak var bidder: UILabel!
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var Description: UILabel!
    
    @IBAction func chatButton(_ sender: Any) {
  
        let bidderRef = FIRDatabase.database().reference().child("Users")
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let stringDate = dateFormatter.string(from: date)
        
        bidderRef.observe(.value, with: { (snapshot) in
      
            for users in snapshot.children.allObjects as! [FIRDataSnapshot]{
                let user = users.value as! [String:Any]
                let username = (user["username"] as! String?)!
                let userid = (user["userID"] as! String?)!
                if username == self.bidder.text! {
          
                    //we have a match so lets find chatroom id
                    let chatRoomID: String?
                    if userid > AppDelegate.user.userID! {
                        chatRoomID = userid + "*" + AppDelegate.user.userID!
                        print("username > userID -> \(chatRoomID!)")
                    }
                    else{
                        chatRoomID = userid + "*" + AppDelegate.user.userID!
                        print("username <= userID -> \(chatRoomID!)")
                    }
                    let initialMessage = [
                        "fromID" : AppDelegate.user.userID!,
                        "destinationID" : userid,
                        "text" : "Hey! You have bid for my post! Let's discuss the bid",
                        "timestamp" : stringDate
                    ]
                    

                    let messageRef = FIRDatabase.database().reference().child("Channels").child(chatRoomID!).childByAutoId()
            
                }
            }
            
        })
    }
    
    
    

    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        pendingPicture.layer.cornerRadius = pendingPicture.frame.size.width/2
        pendingPicture.clipsToBounds = true
        pendingPicture.layer.borderColor = UIColor.white.cgColor
        pendingPicture.layer.borderWidth = 1
        
        
    }
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    public func configure(timeStamp: String, price: String, bidder: String, Description: String, pendingPicture: UIImage){
        self.timeStamp.text = timeStamp
        self.price.text = price
        self.bidder.text = bidder
        self.Description.text = Description
        
        self.pendingPicture.image = pendingPicture
    }
    
}
