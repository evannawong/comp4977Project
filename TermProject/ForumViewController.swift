//
//  ForumViewController.swift
//  TermProject
//
//  Created by Julia Yiu on 2015-11-26.
//  Copyright © 2015 Evanna Wong. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class ForumViewController: UITableViewController
{
    @IBOutlet var courseTableview: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var courses = [Course]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseTableview.backgroundView = UIImageView(image: UIImage(named: "bcit02"))
        
        self.activityIndicator.startAnimating()
        getMongoData()
    }
    
    func getMongoData() {
        let path = "https://api.mongolab.com/api/1/databases/4977db/collections/Courses?apiKey=S5fvstSiHqBeeiQQsvFsvj3AQ2Rw97OL"
        
        Alamofire.request(.GET, path)
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        if let jsonArray = json.array {
                            for courseName in jsonArray {
                                let oneCourse = Course (
                                    course:courseName["course"].stringValue
                                )
                                
                                self.courses.append(oneCourse)
                                self.tableView.reloadData()
                                self.activityIndicator.stopAnimating()
                            }
                        }
                    }
                case .Failure(let error):
                    print(error)
                    
                }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.courses.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "CourseCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ForumTableViewCell
        
        let course = self.courses[indexPath.row]
        
        //Set selected background colour of tableview cells
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 102/255, alpha: 0.8)
        cell.selectedBackgroundView = bgColorView
        
        //Set background colour of tableview cells
        cell.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 0.8)
        
        cell.courseLabel.text = course.Course
        
        return cell
    }
    
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "ShowCourseQuestions") {
            
            let forumController = segue.destinationViewController as! ForumController
            
            let myIndexPath = self.tableView.indexPathForSelectedRow!
            
            let row = myIndexPath.row
            
            forumController.data = self.courses[row]
        }
    }

    

}