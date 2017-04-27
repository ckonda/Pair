//
//  Channel.swift
//  Pair
//
//  Created by Chatan Konda on 4/20/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation


class Channel: NSObject{
    var channelDispID: String?
    var channelID:String?
    var user1ID: String?
    var user2ID: String?
    
    init(channelID: String, user1ID: String, user2ID: String, channelDispID: String?){
        self.channelDispID = channelDispID
        self.channelID = channelID
        self.user1ID = user1ID
        self.user2ID = user2ID
    }
}
