//
//  chatViewController.swift
//  Pair
//
//  Created by Chatan Konda on 4/19/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import Firebase
import FirebaseDatabase

class chatViewController: JSQMessagesViewController{
    
    var newMessageRefHandle: FIRDatabaseHandle?
    
    
   
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var channelRef = FIRDatabase.database().reference().child("Channels")
    var ref: FIRDatabaseReference!
    
    var messages = [JSQMessage]()
    
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()
    
    
    public var selectedchannelID = String()
    public var chatUserID = String()
    public var senderID = String()
    //public var senderDisplayName = String()
    /*public var selectedfromID = String()
    public var selectedIDfrom = String()
    public var selectedIDto = String()
    public var chatUserID = String()
    
    public var selectedtimeStamp = String()
    public var selectedText = String()

    
    public var selectedchannelID = String()//channel ID for the post*/

    


    
    
    var message: Message?{
        didSet{
            title = message?.text
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNavBar()
        print("USER you're chatting with = \(chatUserID)")
        
        title = "Chat Now!"
        
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
        observeMessages()
        
        self.senderId = FIRAuth.auth()?.currentUser?.uid
       
    }
 
    
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    
    private func setupOutgoingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }
    
    
    
    private func setupIncomingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }
    
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = self.messages[indexPath.item]//message retrieved
        if message.senderId == AppDelegate.user.userID {//return the outgoing image view to user
            print("Outgoing message bubble because \(message.senderId) == \(AppDelegate.user.userID)")
            return outgoingBubbleImageView
        }else {//otherwise return the incoming image view
            print("Incoming message bubble because \(self.senderID) != \(AppDelegate.user.userID)")
            return incomingBubbleImageView
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource!{
        return nil//get rid of avatars in the jsq
    }
    
    private func addMessage(withId id: String, name: String, text: String){
        if let message = JSQMessage(senderId: id, displayName: name, text: text){
            messages.append(message)//creates new JSQ message and adds it to the data source
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        let message = messages[indexPath.item]
        
        if message.senderId == AppDelegate.user.userID {
            cell.textView?.textColor = UIColor.white
        }else {
            cell.textView?.textColor = UIColor.black
        }
        return cell//if message is sent by local user, its white else black
    }
    
    
     override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        
        let ref = FIRDatabase.database().reference().child("Channels").child(selectedchannelID)
        let itemRef = ref.childByAutoId()
     //   let itemKey = itemRef.key
        
        //if selectedID1 == AppDelegate.user.userID

        
     
        let messageItem = [
        "fromID": self.senderId,
        "destinationID": chatUserID,
        "timestamp": "Timestamp",
        "text": text,//(AppDelegate.user.username! + ":" + selectedText),
        ]
        
        itemRef.setValue(messageItem)
        
        //JSQSystemSoundPlayer.jsq_playMessageSentSound()
        
        
        finishSendingMessage()

    }
    
    
    
    
    private func observeMessages() {
       // messageRef = messageRef.child("Messages")
        let messageQuery = channelRef.child(selectedchannelID).queryLimited(toLast:25)
        
         //We can use the observe method to listen for new
        // messages being written to the Firebase DB
        newMessageRefHandle = messageQuery.observe(.childAdded, with: { (snapshot) -> Void in
        
            let channelData = snapshot.value as! Dictionary<String, String>
            
            print(snapshot.value!)
            
            if let fromid = channelData["fromID"] as String!, let toid = channelData["destinationID"] as String!, let text = channelData["text"] as String!, let timestamp = channelData["timestamp"]{
            
                //self.addMessage(withId: self.senderId, name: name, text: text)
               // self.addMessage(withId: <#T##String#>, name: <#T##String#>, text: <#T##String#>)
                /*let userRef = FIRDatabase.database().reference().child("Users").child(fromid)
                userRef.observeSingleEvent(of: .value, with: { (userSnapshot) in
                    let userRefDat = userSnapshot.value as! [String: Any]
                    let user = userRefDat["username"] as! String?
                    self.addMessage(withId: fromid, name: user!, text: text)
                    print("message was added from \(fromid) to \(toid)")
                })*/
                
               self.addMessage(withId: fromid, name: AppDelegate.user.username!, text: text)
                
                
        
                self.finishReceivingMessage()
            } else {
                print("Error! Could not decode message data")
            }
        })
    }
    
    
    
    

    
    func addNavBar() {
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height:65)) // Offset by 20 pixels vertically to take the status bar into account
        
        navigationBar.barTintColor = UIColor.init(red: 84.0/255.0, green: 211.0/255.0, blue: 187.0/255.0, alpha: 1.0)

        
        navigationBar.tintColor = UIColor.white
        
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = "Chat Box"
        
        
        // Create left and right button for navigation item
        let leftButton =  UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(btn_clicked(_:)))
        
        let rightButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(done_button(_:)))
        
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)
    }

    
    func btn_clicked(_ sender: UIBarButtonItem) {
        // Do something
        dismiss(animated: true, completion: nil)
    }
    
    func done_button(_ sender: UIBarButtonItem){
        
        
            performSegue(withIdentifier: "gotoRating", sender: self)
        
        
        print("JOB HAS FINISHED")
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "gotoRating"){
            
            let destination = segue.destination as! rateViewController
            destination.userID = chatUserID
            
            
            
        }
    }

    
    
 
    
    
    
 
    
    
}
