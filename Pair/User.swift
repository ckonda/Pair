//
//  User.swift
//  Pair
//
//  Created by Chatan Konda on 4/9/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation


public class User: NSObject {
    var username: String?
    var email: String?
    var password: String?
    var userID: String?
    var profileImageUrl: String?
    
    
    func initialize(username: String?, email: String?, password: String?,userID: String?, profileImageUrl: String?){
        self.username = username;
        self.email = email;
        self.password = password;
        self.userID = userID;
        self.profileImageUrl = profileImageUrl;
    }
    
}


