//
//  JobModel.swift
//  Pair
//
//  Created by Radhakrishna Canchi on 4/9/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

public class JobModel{
    
    public var job: String?
    public var price: Int?
//    public var skill: String?
    public var username: String?
    public var description: String?
    
    init(job:String?, price:Int?, username:String?, description: String?){
        self.job = job
        self.price = price
      //  self.skill = skill
        self.username = username
        self.description = description
    }
}
