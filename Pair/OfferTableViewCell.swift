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
    

    
    
    @IBOutlet weak var offerLabel: UILabel!
    
    
    @IBOutlet weak var offerPrice: UILabel!
    
    
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   
    
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    public func configure(offerLabel: String, offerPrice: String){
        self.offerLabel.text = offerLabel
        self.offerPrice.text = offerPrice
    }
    
}

