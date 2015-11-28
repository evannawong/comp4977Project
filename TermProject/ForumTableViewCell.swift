//
//  ForumTableViewCell.swift
//  TermProject
//
//  Created by Julia Yiu on 2015-11-26.
//  Copyright © 2015 Evanna Wong. All rights reserved.
//

import UIKit

//Represents a custom Course table cell
class ForumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var courseLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
