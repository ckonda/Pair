//
//  JobModel.swift
//  Pair
//
//  Created by Radhakrishna Canchi on 4/9/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

public class JobModel{
    
    public var jobName: String?
    public var price: Int?
    public var username: String?//userid
    public var description: String?
    public var postid : String?
    
    init(jobName:String?, price:Int?, username:String?, description: String?, postid: String?){
        self.jobName = jobName
        self.price = price
        self.username = username
        self.description = description
        self.postid = postid
    }
}
