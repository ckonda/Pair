//
//  Message.swift
//  Pair
//
//  Created by Chatan Konda on 4/16/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation


class Message: NSObject {
    
    
    var fromID: String?
    var text: String?
    var timestamp: NSNumber?
    var toID: String?
    var messageID: String?
    
    
    
    init(fromID:String?, text:String?, timestamp:NSNumber?, toID: String?, messageID: String?){
        self.fromID = fromID
        self.text = text
        self.timestamp = timestamp
        self.toID = toID
        self.messageID = messageID
        
    }
    
}
