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
    
    @IBOutlet weak var questionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMongoData()
    }
    
    func getMongoData() {
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
        
        cell.questionLabel.text = entry.Question
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "questionDetails") {
            
            let questionDetailsViewController = segue.destinationViewController as! QuestionDetailViewController
            
            let myIndexPath = self.tableView.indexPathForSelectedRow!
            
            let row = myIndexPath.row
            
            questionDetailsViewController.data = self.entries[row]
        } else if(segue.identifier == "submitQuestion") {
            
            let submitQuestionViewController = segue.destinationViewController as! SubmitQuestionViewController
            
            
            submitQuestionViewController.courseName = self.course
        }
    }
    
}