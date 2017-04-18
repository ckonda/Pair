//
//  MessagesTableViewCell.swift
//  Pair
//
//  Created by Chatan Konda on 4/17/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation


public class MessagesTableViewCell: UITableViewCell {
    

    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    public func configure(jobLabel: String, descriptionLabel:String){
        
        
//        self.jobLabel.text = jobLabel
//        self.descriptLabel.text = descriptionLabel
    }
    
}

