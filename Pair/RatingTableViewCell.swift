//
//  RatingTableViewCell.swift
//  Pair
//
//  Created by Chatan Konda on 4/25/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import Firebase



public class RatingTableViewCell: UITableViewCell {
    @IBOutlet weak var raterPicture: UIImageView!
    
    @IBOutlet weak var rater: UILabel!

    @IBOutlet weak var raterValue: UILabel!
    

    @IBOutlet weak var comments: UITextView!
    
    @IBOutlet weak var dot1: UIImageView!
    @IBOutlet weak var dot2: UIImageView!
    @IBOutlet weak var dot3: UIImageView!
    @IBOutlet weak var dot4: UIImageView!
    @IBOutlet weak var dot5: UIImageView!
    
    
    
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

        raterPicture.layer.cornerRadius = raterPicture.frame.size.width/2
        raterPicture.clipsToBounds = true
        raterPicture.layer.borderColor = UIColor.white.cgColor
        raterPicture.layer.borderWidth = 1
 
        
        
        comments.layer.borderColor = UIColor.gray.cgColor

    }
    
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(raterValue: String? , raterPicture: UIImage, comments: String?, rater: String?, dot1: UIImage,dot2: UIImage,dot3: UIImage,dot4: UIImage, dot5: UIImage){
        self.raterValue.text = raterValue
        self.raterPicture.image = raterPicture
        self.comments.text = comments
        self.rater.text = rater
        
        self.dot1.image = dot1
        self.dot2.image = dot2
        self.dot3.image = dot3
        self.dot4.image = dot4
        self.dot5.image = dot5
    
    }
    
}


