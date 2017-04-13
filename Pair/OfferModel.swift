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
    //public var skill: String?
    public var username: String?
    public var description: String?
    
    init(offer:String?, price:Int?, username:String?, description: String?){
        self.offer = offer
        self.price = price
        self.username = username
        self.description = description
    }
}
