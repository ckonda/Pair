//
//  initialMessageViewController.swift
//  Pair
//
//  Created by Chatan Konda on 4/27/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class initialMessageViewController: UIViewController {
    //var bidderID: String?
    //var user1ID: String?
    @IBOutlet weak var acceptedLabel: UILabel!
    //var user2ID: String?
    var ref = FIRDatabase.database().reference()
    @IBOutlet weak var messageBoxLabel: UITextView!
    @IBOutlet weak var typeMessageLabel: UILabel!
    //var bidData = [pastBids]()
    var loc: Int?
    //var bidInfo = bidData[loc]
    var currentBid: pastBids?
    //Check if posterID = Appdelegate.user.userID
    //check bidder id to who the bidder is
    //if both conditions are true send message
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func sendButton(_ sender: Any) {
        print("loc = \(loc)")
        print("bidder name = \(currentBid?.name)")
        if (messageBoxLabel.text != nil){
            //newMessageRef =
            let user1 = AppDelegate.user.userID!
            let user2 = currentBid?.bidderID!
            let channelID: String?
            if user1 > user2! {
                print("user1 = \(user1)")
                print("user2 = \(user2)")
                channelID = user1 + "*" + user2!
                print("new channel id = \(channelID!)")
            }
            else{
                print("user1 = \(user1)")
                print("user2 = \(user2!)")
                channelID = user2! + "*" + user1
                print("new channel id = \(channelID!)")
            }
            let messageRef = ref.child("Channels").child(channelID!)
            let messageID = messageRef.childByAutoId()
            
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
            let stringDate = dateFormatter.string(from: date)
            
            let messageJSON = [
                "destinationID": currentBid?.bidderID!,
                "fromID": AppDelegate.user.userID!,
                "text": messageBoxLabel.text!,
                "timestamp": stringDate
            ]
            messageID.setValue(messageJSON)
            dismiss(animated: true, completion: nil)
            //let user2Name
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        acceptedLabel.text = "You have accepted \((currentBid?.name!)!)'s bid! "
        typeMessageLabel.text = "Connect with \((currentBid?.name!)!) by sending a message:"
        
        //print(user1ID)
        //print("biddata.count = \(bidData.count)")
        //print("bidder = \(bidderID)")
        //print("bidder[\(loc)] = \(bidData[loc!].name)")
        /*for bids in bidData{
            print("posterID = \(bids.ownerID)")
            print("ownerID = \(bids.bidderID)")
        }*/
        /*ref.observe(.value, with: { (snapshot) in
            
            //print(snapshot)
            for bids in snapshot.children.allObjects as! [FIRDataSnapshot]{
                //print(bids)
                let bid = snapshot.value as! [String:Any]
                var name = bid["name"] as! String?
                var ownerID = bid["ownerID"] as! String?
            
                
            }
            
            
        })*/
        
        
        
        //print(user2ID)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
