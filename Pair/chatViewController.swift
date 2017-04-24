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

class chatViewController: JSQMessagesViewController {
    
    var newMessageRefHandle: FIRDatabaseHandle?
    
    
   
    
    @IBAction func backButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    var messageRef = FIRDatabase.database().reference().child("Messages")
    var ref: FIRDatabaseReference!
    
    var messages = [JSQMessage]()
    
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()
    
    
    public var selectedfromID = String()
    public var selectedtoID = String()
    public var selectedtimeStamp = String()
    public var selectedMessageID = String()//the ID for the current post
    public var selectedText = String()
    
    public var selectedchannelID = String()//channel ID for the post

    


    
    
    var message: Message?{
        didSet{
            title = message?.text
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(selectedfromID)
//        print(selectedtimeStamp)
//        print(selectedText)
//        print(selectedMessageID)
//        print(selectedtoID)
        
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
        let message = messages[indexPath.item]//message retrieved
        if message.senderId == senderId {//return the outgoing image view to user
            return outgoingBubbleImageView
        }else {//otherwise return the incoming image view
            return incomingBubbleImageView
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource!{
        return nil//get rid of avatars in the jsq
    }
    
    private func addMessage(withId id: String, name: String, text: String){
        if let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text){
            messages.append(message)//creates new JSQ message and adds it to the data source
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        let message = messages[indexPath.item]
        
        if message.senderId == senderId {
            cell.textView?.textColor = UIColor.white
        }else {
            cell.textView?.textColor = UIColor.black
        }
        return cell//if message is sent by local user, its white else black
    }
    
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        
        let ref = FIRDatabase.database().reference().child("Messages")
        let itemRef = ref.childByAutoId()
     //   let itemKey = itemRef.key
        
        let messageItem = [
        "fromID": selectedfromID,
        "destinationID": selectedtoID,
        "timestamp": selectedtimeStamp,
        "text": (AppDelegate.user.username! + ":" + selectedText),
        ]
        
        itemRef.setValue(messageItem)
        
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        
        
        finishSendingMessage()

    }
    
    
    
    
    private func observeMessages() {
        print("entered obserev messages")
       // messageRef = messageRef.child("Messages")
        print("messageRef declared")
        let messageQuery = messageRef.queryLimited(toLast:25)
        
         //We can use the observe method to listen for new
        // messages being written to the Firebase DB
        newMessageRefHandle = messageQuery.observe(.childAdded, with: { (snapshot) -> Void in
        
            let messageData = snapshot.value as! Dictionary<String, String>
            
            print(snapshot.value!)
            
            if let fromid = messageData["fromID"] as String!, let name = messageData["destinationID"] as String!, let text = messageData["text"] as String!, let timestamp = messageData["timestamp"]{
            
                self.addMessage(withId: fromid, name: name, text: text)
                
                print(self.selectedMessageID)
                print(self.selectedText)
                
        
                self.finishReceivingMessage()
            } else {
                print("Error! Could not decode message data")
            }
        })
    }
    
//    
//    senderId
//    The unique identifier for the user who sent the message. This value must not be `nil`.
//    displayName
//    The display name for the user who sent the message. This value must not be `nil`.
//    text
//    The body text of the message. This value must not be `nil`.

    
    
    
    
    
    
    
}
