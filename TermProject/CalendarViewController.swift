//
//  CalendarViewController.swift
//  TermProject
//
//  Created by Guanyi Fang on 2015-11-27.
//  Copyright © 2015 Evanna Wong. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CalendarViewController: UIViewController {
    
    @IBOutlet var calendarView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var eventTitle: UITextField!
    @IBOutlet weak var eventLocation: UITextField!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var eventView: UITextView!
    
    @IBAction func hourStepper(sender: UIStepper) {
        self.hourLabel.text = sender.value.description
    }
    
    
    @IBAction func saveButtonPressed(sender: UIButton) {
        let eventTime = datePicker.date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .MediumStyle
        let eventTimeString = dateFormatter.stringFromDate(eventTime)
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month, .Day], fromDate: eventTime)
        
        //year, month and day are for later searching
        let year: Int = components.year
        let month: Int = components.month
        let day: Int = components.day
        let duration: String = hourLabel.text!
        let title: String = eventTitle.text!
        let location:String = eventLocation.text!
        let event : [String:AnyObject] =
        [
            "eventTitle" : title,
            "eventLocation" : location,
            "year" : year,
            "month" : month,
            "day" : day,
            "timeString" : eventTimeString,
            "duration" : duration
        ]
        
        Alamofire.request(.POST, "https://api.mongolab.com/api/1/databases/firstmongo/collections/iosProject?apiKey=JosaVGrEGYbVAdO3q-WTOK6_mNvPOXoX", parameters: event, encoding: .JSON).responseJSON { response in
            if response.result.isSuccess {
                    //print(responseresult)
                self.eventView.text = "Event Saved"
            }
            else {
                self.eventView.text = "Event cannot be saved"
            }
        }
        
    }

    
    @IBAction func timeChanged(sender: UIDatePicker) {
        let time = datePicker.date
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute], fromDate: time)
        let year: String = String(components.year)
        let month: String = String(components.month)
        let day: String = String(components.day)
        Alamofire.request(.GET, "https://api.mongolab.com/api/1/databases/firstmongo/collections/iosProject?apiKey=JosaVGrEGYbVAdO3q-WTOK6_mNvPOXoX").responseJSON { response in
            if let value = response.result.value {
                //print("JSON: \(value)"
                self.eventView.text = ""
                var eventList = (JSON(value))
                for var i = 0; i < eventList.count; i++ {
                    if String(eventList[i]["year"]) == year &&
                        String(eventList[i]["month"]) == month &&
                        String(eventList[i]["day"]) == day
                    {
                        let eventInfo: String = "Event Title: " + String(eventList[i]["eventTitle"]) + "\nLocation: " + String(eventList[i]["eventLocation"]) + "\nTime: " + String(eventList[i]["timeString"]) + "\nHours: " + String(eventList[i]["duration"]) + "\n--------------------------------------------\n"
                        self.eventView.text.appendContentsOf(eventInfo)
                        print(eventList[i])
                    }
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.backgroundColor = UIColor(patternImage: UIImage(named: "bcit01.jpg")!)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}