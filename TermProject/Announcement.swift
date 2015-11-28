//
//  Announcement.swift
//  TermProject
//
//  Created by Victor on 2015-11-19.
//  Copyright © 2015 Evanna Wong. All rights reserved.
//
//  This represents an announcement

import Foundation

class Announcement {
    var Date: String
    var Time: String
    var Category: String
    var Message: String
    var Detail: String
    var Contact: String
    var Location: String
    
    init(date: String?, time: String?, category: String?, message: String?, detail: String?, contact: String?, location: String?) {
        self.Date = date!
        self.Time = time!
        self.Category = category!
        self.Message = message!
        self.Detail = detail!
        self.Contact = contact!
        self.Location = location!
    }
}