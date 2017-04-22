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
    
    
    @IBOutlet weak var locationLabel: UILabel!
    
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     
    }
    
    public func configure(postLabel: String, postPrice:String, locationLabel: String){
        self.postLabel.text = postLabel
//        self.descriptionLabel.text = descriptionLabel
        self.postPrice.text = postPrice
        self.locationLabel.text = locationLabel
    }

}
