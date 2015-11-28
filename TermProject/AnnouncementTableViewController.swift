//
//  AnnouncementTableViewController.swift
//  TermProject
//
//  Created by Victor on 2015-11-19.
//  Copyright © 2015 Evanna Wong. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AnnouncementTableViewController: UITableViewController{
    
    
    @IBOutlet var announcementTable: UITableView!
    
    //Array of Announcement objects to hold return data from GET request
    var announcements = [Announcement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        announcementTable.backgroundView = UIImageView(image: UIImage(named: "bcit01"))
        
        getData()
    }
    
    //Send GET request and populate announcements array
    func getData(){
        //Request path
        let path = "https://api.mongolab.com/api/1/databases/comp4977project/collections/Announcement?apiKey=QNwCXLgMzmjtezI0ZIubDsy0QZkKdWAX"
        
        Alamofire.request(.GET, path)
            .responseJSON { response in
            switch response.result {
            case .Success:
            if let value = response.result.value {
                let json = JSON(value)
                    if let jsonArray = json.array {
                        for announcement in jsonArray {
                            let oneAnnouncement = Announcement (
                                date:announcement["Date"].stringValue,
                                time:announcement["Time"].stringValue,
                                category:announcement["Category"].stringValue,
                                message:announcement["Message"].stringValue,
                                detail:announcement["Details"].stringValue,
                                contact:announcement["Contact"].stringValue,
                                location:announcement["Location"].stringValue
                            )
                            
                            self.announcements.append(oneAnnouncement)
                           
                            self.tableView.reloadData()
                        }
                    }
                }
            case .Failure(let error):
                print(error)
                
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.announcements.count
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "AnnouncementCell"
        
        //Connect to AnnouncementTableViewCell (The custom tableview cell)
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! AnnouncementTableViewCell
        
        let announcement = self.announcements[indexPath.row]
        
        //Set selected background colour of tableview cells
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 102/255, alpha: 0.8)
        cell.selectedBackgroundView = bgColorView
        
        //Set background colour of tableview cells
        cell.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 0.8)
        
        //Setting label text
        cell.dateLabel.text = announcement.Date
        cell.messageLabel.text = announcement.Message
        cell.locationLabel.text = announcement.Location
        cell.timeLabel.text = announcement.Time
        
        return cell
    }
    
    //Allows data from this controller to be passed to AnnouncementDetailViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "ShowAnnouncementDetails") {
            
            //Cast allows this controller to access the "data" property in AnnouncementDetailViewController
            let announcementViewController = segue.destinationViewController as! AnnouncementDetailViewController
            
            let myIndexPath = self.tableView.indexPathForSelectedRow!
        
            let row = myIndexPath.row
            
            //Assigns the value of the selected row to the data property in AnnouncementDetailViewController
            announcementViewController.data = self.announcements[row]
        }
    }

}
