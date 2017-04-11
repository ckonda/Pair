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
   
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var offerLabel: UILabel!
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    public func configure(jobLabel: String, descriptionLabel:String){
        self.offerLabel.text = jobLabel
        self.descriptionLabel.text = descriptionLabel
    }
    
}

