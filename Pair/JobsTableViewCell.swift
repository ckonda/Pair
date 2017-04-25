//
//  JobsTableViewCell.swift
//  Pair
//
//  Created by Radhakrishna Canchi on 4/8/17.
//  Copyright © 2017 Apple. All rights reserved.


import UIKit
import Firebase
import FirebaseAuth

public class JobsTableViewCell: UITableViewCell {
    @IBOutlet weak var postLabel: UILabel!
    

    
    @IBOutlet weak var postPrice: UILabel!
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var timestamp: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2
        profilePicture.clipsToBounds = true
        profilePicture.layer.borderColor = UIColor.white.cgColor
        profilePicture.layer.borderWidth = 1
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     
    }
    
    public func configure(postLabel: String, postPrice:String, locationLabel: String, profilePicture: UIImage, timestamp: String){
        self.postLabel.text = postLabel
//        self.descriptionLabel.text = descriptionLabel
        self.postPrice.text = postPrice
        self.locationLabel.text = locationLabel
        self.profilePicture.image = profilePicture
        self.timestamp.text = timestamp
    }

}
