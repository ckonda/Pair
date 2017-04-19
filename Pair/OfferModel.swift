//
//  OfferModel.swift
//  Pair
//
//  Created by Chatan Konda on 4/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

public class OfferModel{
    
    public var offer: String?
    public var price: Int?
    public var username: String?//offer user id
    public var skill: String?
    public var offerid: String?
    
    init(offer:String?, price:Int?, username:String?, skill: String?, offerid: String?){
        self.offer = offer
        self.price = price
        self.username = username
        self.skill = skill
        self.offerid = offerid
    }
    
    
}
