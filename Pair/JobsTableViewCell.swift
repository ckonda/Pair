//
//  JobsTableViewCell.swift
//  Pair
//
//  Created by Radhakrishna Canchi on 4/8/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

public class JobsTableViewCell: UITableViewCell {
    @IBOutlet weak var jobLabel: UILabel!
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(jobLabel: String, descriptionLabel:String){
        self.jobLabel.text = jobLabel
        self.descriptionLabel.text = descriptionLabel
    }

}
