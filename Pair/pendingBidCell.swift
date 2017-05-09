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


//    @IBOutlet weak var messagePicture: UIImageView!
    
    
    @IBAction func chatButton(_ sender: Any) {
        //chatButton.tag
        
        print(bidder)
        let bidderRef = FIRDatabase.database().reference().child("Users")
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let stringDate = dateFormatter.string(from: date)
        
        bidderRef.observe(.value, with: { (snapshot) in
            //print(snapshot.value)
            for users in snapshot.children.allObjects as! [FIRDataSnapshot]{
                let user = users.value as! [String:Any]
                //print("\((user["username"] as! String?)!) : \((user["userID"] as! String?)!)")
                let username = (user["username"] as! String?)!
                let userid = (user["userID"] as! String?)!
                if username == self.bidder.text! {
                    //print("we have a match. Your bidder in this cell is \(username) with an id of \(userid)")
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
                    //messageRef.setValue(initialMessage)
                    
                    
                }
            }
            
        })
        //chatButton.add
        //observe
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
