//
//  messagesViewController.swift
//  Pair
//
//  Created by Chatan Konda on 4/17/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Firebase


enum Section: Int {
    case createNewMessageSection = 0//for saving data to firebase
    case currentChannelSection//listen for new data to save to firebase
}




class messagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var senderDisplayName: String?
  //  var newMessageTextField: UITextField?
    private var messages = [Message]()//hold messages in block

    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessagesTableViewCell
        
        
       
        return cell
    }
    
    @IBAction func cancelView(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    


}
