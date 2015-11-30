//
//  ForumController.swift
//  TermProject
//
//  Created by Julia Yiu on 2015-11-26.
//  Copyright © 2015 Evanna Wong. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ForumController: UITableViewController
{
    var data = Course(course: "")
    var entries = [Entry]()
    var course: String = ""
    var responsesArr = [String]()
    
    @IBOutlet var questionTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getMongoData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        questionTableView.backgroundView = UIImageView(image: UIImage(named: "bcit02"))
        self.activityIndicator.startAnimating()
        self.getMongoData()
 
    }
    
    func getMongoData() {
        self.entries = []
        course = data.Course

        let path = "https://api.mongolab.com/api/1/databases/4977db/collections/" + course + "?apiKey=S5fvstSiHqBeeiQQsvFsvj3AQ2Rw97OL"
        
        Alamofire.request(.GET, path).responseJSON {
            response in switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
 
                    if let jsonArray = json.array {
                        for entry in jsonArray {
                            let oneEntry = Entry (
                                question: entry["question"].stringValue
                            )
                            
                            self.entries.append(oneEntry)
                            dispatch_async(dispatch_get_main_queue()){
                                self.tableView.reloadData()

                            }
                            
                            self.activityIndicator.stopAnimating()
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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return entries.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "QuestionCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! QuestionTableViewCell
        
        let entry = self.entries[indexPath.row]
        
        //Set selected background colour of tableview cells
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 102/255, alpha: 0.8)
        cell.selectedBackgroundView = bgColorView
        
        //Set background colour of tableview cells
        cell.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 0.8)
        
        cell.questionLabel.text = entry.Question
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "questionDetails") {
            
            let questionDetailsViewController = segue.destinationViewController as! QuestionDetailViewController
            
            let myIndexPath = self.tableView.indexPathForSelectedRow!
            
            let row = myIndexPath.row
            
            questionDetailsViewController.data = self.entries[row]
            questionDetailsViewController.quest = self.entries[row].Question
            questionDetailsViewController.course = data.Course
            
        } else if(segue.identifier == "submitQuestion") {
            
            let submitQuestionViewController = segue.destinationViewController as! SubmitQuestionViewController
            
            
            submitQuestionViewController.courseName = self.course
        }
    }
    
}