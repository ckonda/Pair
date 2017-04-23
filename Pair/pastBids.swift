//
//  pastBids.swift
//  Pair
//
//  Created by Rahul Vemuri on 4/22/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation


public class pastBids{
    
    var postPrice: String?
    var postID: String?
    var bidderID: String?
    var ownerID: String?
    
    

    
    init(postPrice: String?, postID: String?, bidderID: String?, ownerID: String){
        self.postPrice = postPrice
        self.postID = postID
        self.bidderID = bidderID
        self.ownerID = ownerID
  
    }
    
    
}
