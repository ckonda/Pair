//
//  JobModel.swift
//  Pair
//
//  Created by Radhakrishna Canchi on 4/9/17.
//  Copyright © 2017 Apple. All rights reserved.
//

public class JobModel{
    
    public var jobName: String?
    public var price: Int?
    public var username: String?//userid
    public var description: String?
    public var postid : String?
    public var profileImageUrl: String?
    public var location: String?
    public var name: String?
    
    init(jobName:String?, price:Int?, username:String?, description: String?, postid: String?, profileImageUrl: String?, location: String?, name: String?){
        self.jobName = jobName
        self.price = price
        self.username = username
        self.description = description
        self.postid = postid
        self.profileImageUrl = profileImageUrl
        self.location = location
        self.name = name
    }
}
