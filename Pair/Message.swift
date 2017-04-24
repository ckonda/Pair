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
    var timestamp: String?
    var destinationID: String?
    var name: String?
    
    
    init(fromID:String?, text:String?, timestamp:String?, destinationID: String?){
        self.fromID = fromID
        self.text = text
        self.timestamp = timestamp
        self.destinationID = destinationID
    }
    
}
