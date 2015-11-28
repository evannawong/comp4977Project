//
//  AnnouncementDetailViewController.swift
//  TermProject
//
//  Created by Victor on 2015-11-21.
//  Copyright © 2015 Evanna Wong. All rights reserved.
//
//  AnnouncementDetailViewController is called when the user selects an item from the IUTableView in the Announcements page.

import UIKit

class AnnouncementDetailViewController: UIViewController {
    
    //Labels on the view
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var detailTextfield: UITextView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    //Initialize empty Announcement object
    var data = Announcement(date: "", time: "", category: "", message: "", detail: "", contact: "", location: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set label text to data that was passed in from AnnouncementController
        self.dateLabel.text = self.data.Date
        self.messageLabel.text = self.data.Message
        self.detailTextfield.text = self.data.Detail
        self.timeLabel.text = self.data.Time
        self.locationLabel.text = self.data.Location
    }
    
    
}
