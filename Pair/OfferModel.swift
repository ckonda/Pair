//
//  OfferModel.swift
//  Pair
//
//  Created by Chatan Konda on 4/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

public class OfferModel{
    
    public var job: String?
    public var price: Int?
    public var skill: String?
    public var username: String?
    
    init(job:String?, price:Int?, skill:String?, username:String?){
        self.job = job
        self.price = price
        self.skill = skill
        self.username = username
    }
}
