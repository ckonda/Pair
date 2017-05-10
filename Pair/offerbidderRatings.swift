//
//  offerbidderRatings.swift
//  Pair
//
//  Created by Chatan Konda on 5/9/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation



public class offerbidderRatings{
    
    var comments: String?
    var rater: String?
    var ratingValue: Int?
    var raterID: String?
    
    
    init(comments: String? , rater: String?, ratingValue: Int?, raterID: String?){
        self.comments = comments
        self.rater = rater
        self.ratingValue = ratingValue
        self.raterID = raterID
        
    }
    
}
