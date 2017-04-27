//
//  MessagesTableViewCell.swift
//  Pair
//
//  Created by Chatan Konda on 4/17/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation


public class MessagesTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var senderName: UILabel!
    
    @IBOutlet weak var timeStamp: UILabel!
    
    
    @IBOutlet weak var messagePicture: UIImageView!
    
    
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        messagePicture.layer.cornerRadius = messagePicture.frame.size.width/2
        messagePicture.clipsToBounds = true
        messagePicture.layer.borderColor = UIColor.white.cgColor
        messagePicture.layer.borderWidth = 1
        
        
    }
    
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(senderName: String, timeStamp: String, messagePicture: UIImage){
        
        self.senderName.text = senderName
        self.timeStamp.text = timeStamp
        self.messagePicture.image = messagePicture
        
    }
    
}


