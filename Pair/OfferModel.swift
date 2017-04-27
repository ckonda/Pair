//
//  OfferModel.swift
//  Pair
//
//  Created by Chatan Konda on 4/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation


public class OfferModel{
    
    public var offerName: String?
    public var price: Int?
    public var username: String?//offer user id
    public var skill: String?
    public var offerid: String?
    public var profileImageUrl: String?
    public var location: String?
    public var name: String?
    public var timestamp: String?
    
    
    
    init(offerName:String?, price:Int?, username:String?, skill: String?, offerid: String?, profileImageUrl: String?, location: String?, name: String?, timestamp: String?){
        self.offerName = offerName
        self.price = price
        self.username = username
        self.skill = skill
        self.offerid = offerid
        self.profileImageUrl = profileImageUrl
        self.location = location
        self.name = name
        self.timestamp = timestamp
        
    }
    
    
}
