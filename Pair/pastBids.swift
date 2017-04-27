//
//  pastBids.swift
//  Pair
//
//  Created by Chatan Konda on 4/23/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation


public class pastBids{
    
    var postPrice: Int?
    var postID: String?
    var bidderID: String?
    var ownerID: String?
    var timeStamp: String?
    var name: String?
    var Description: String?
    
    
    
    
    init(postPrice: Int?, postID: String?, bidderID: String?, ownerID: String, timeStamp: String,Description: String?, name: String?){
        self.postPrice = postPrice
        self.postID = postID
        self.bidderID = bidderID
        self.ownerID = ownerID
        self.timeStamp = timeStamp
        self.Description = Description
        self.name = name
    }
    
    
}
