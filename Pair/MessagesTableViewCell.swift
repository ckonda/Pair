//
//  MessagesTableViewCell.swift
//  Pair
//
//  Created by Chatan Konda on 4/17/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation


public class MessagesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var fromID: UILabel!
    @IBOutlet weak var timeStamp: UILabel!

    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    public func configure(fromID: String, timeStamp: String){
        
        self.fromID.text = fromID
        self.timeStamp.text = timeStamp

    }
    
}

