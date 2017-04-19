//
//  messagesViewController.swift
//  Pair
//
//  Created by Chatan Konda on 4/17/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

enum Section: Int {
    case createNewMessageSection = 0//for saving data to firebase
    case currentChannelSection//listen for new data to save to firebase
}


class messagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var senderDisplayName: String?
  //  var newMessageTextField: UITextField?
    private var messages = [Message]()//hold messages in block

    private lazy var messageRef:FIRDatabaseReference = FIRDatabase.database().reference().child("Messages")
    
    private var messageRefHandle: FIRDatabaseHandle?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "RW RIC"
        observeMessages()
        
        
     
        self.tableView.reloadData()
        
    }
    
    deinit {
        if let refhandle = messageRefHandle{
            messageRef.removeObserver(withHandle: refhandle)
        }
    }
    
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessagesTableViewCell
        
        let message = messages[indexPath.row]
        
        cell.fromID.text = message.fromID
        cell.timeStamp.text = String(describing: message.timestamp)
        
       
        return cell
    }
    
    @IBAction func cancelView(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    private func observeMessages(){
        
        messageRefHandle = messageRef.observe(.childAdded, with: { (snapshot) in
            let messagesData = snapshot.value as! Dictionary<String, AnyObject>
            let messageID = snapshot.key
            
            if let name = messagesData["name"] as! String! {
//                self.messages.append(Message(fromID: <#T##String?#>, text: <#T##String?#>, timestamp: <#T##NSNumber?#>, toID: <#T##String?#>, messageID: <#T##String?#>))
                
            }else{
                print("could not decode channel data")
            }
            
            
            
        })
    }
    
    
    
    
    
    


}
