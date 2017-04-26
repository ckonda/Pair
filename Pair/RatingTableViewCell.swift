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
    
    @IBOutlet weak var comments: UILabel!
    
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
 
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


