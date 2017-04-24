//
//  pendingBidCell.swift
//  Pair
//
//  Created by Chatan Konda on 4/23/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation



public class pendingBidCell: UITableViewCell {
    
    
    @IBOutlet weak var timeStamp: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    public func configure(timeStamp: String){
        self.timeStamp.text = timeStamp
    }
    
}
