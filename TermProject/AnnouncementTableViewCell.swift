//
//  AnnouncementTableViewCell.swift
//  TermProject
//
//  Created by Victor on 2015-11-18.
//  Copyright © 2015 Evanna Wong. All rights reserved.
//
//  AnnouncementTableViewCell represents the custom tableview cell in the announcement tableview.

import UIKit

class AnnouncementTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
