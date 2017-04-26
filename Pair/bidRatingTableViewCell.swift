//
//  bidRatingTableViewCell.swift
//  Pair
//
//  Created by Chatan Konda on 4/26/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation



public class bidRatingTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var comments: UITextView!
    
    @IBOutlet weak var raterValue: UILabel!
    
    @IBOutlet weak var rater: UILabel!
    
    @IBOutlet weak var raterPicture: UIImageView!
    
    
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
        raterPicture.layer.cornerRadius = raterPicture.frame.size.width/2
        raterPicture.clipsToBounds = true
        raterPicture.layer.borderColor = UIColor.white.cgColor
        raterPicture.layer.borderWidth = 1

    }
    
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(raterValue: String? , raterPicture: UIImage, comments: String?, rater: String?){
        self.raterValue.text = raterValue
        self.raterPicture.image = raterPicture
        self.comments.text = comments
        self.rater.text = rater
        
    }
    
}
