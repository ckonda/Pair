//
//  OfferTableViewCell.swift
//  Pair
//
//  Created by Chatan Konda on 4/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import Firebase


public class OfferTableViewCell: UITableViewCell {


    @IBOutlet weak var offerPrice: UILabel!
    
    @IBOutlet weak var timestamp: UILabel!
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var offerLabel: UILabel!
    
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2
        profilePicture.clipsToBounds = true
        profilePicture.layer.borderColor = UIColor.white.cgColor
        profilePicture.layer.borderWidth = 1
    }
    
    
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    public func configure(offerPrice: String, timestamp: String, profilePicture: UIImage, locationLabel: String, offerLabel: String){
       
        self.profilePicture.image = profilePicture
        self.offerPrice.text = offerPrice
        self.timestamp.text = timestamp
        self.locationLabel.text = locationLabel
        self.offerLabel.text = offerLabel
    }
 
    
    
}

