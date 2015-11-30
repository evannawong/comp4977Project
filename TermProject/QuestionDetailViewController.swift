//
//  QuestionDetailViewController.swift
//  TermProject
//
//  Created by Julia Yiu on 2015-11-27.
//  Copyright © 2015 Evanna Wong. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class QuestionDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data = Entry(question: "")
    var quest: String = ""
    var course: String = ""
    var response = [String]()
    var test = "question"
    var test2 = "response_array"
    var test3 = "_id"
    
    @IBOutlet weak var responseTable: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var responseText: UITextView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //self.response = []
        self.getMongoData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = (UIColor(patternImage: UIImage(named: "bcit01.jpg")!))
        
        self.responseText.layer.borderWidth = 0.5
        self.responseText.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.responseText.layer.cornerRadius = 8
        self.submitButton.layer.cornerRadius = 8
        //self.responseText.becomeFirstResponder()
        //getMongoData()
        questionLabel.text = quest
        responseTable.delegate = self
        responseTable.dataSource = self
        
    }
    
    @IBAction func reponseSubmit(sender: AnyObject) {
        let alertFull = UIAlertController(title: "Question Submitted", message:
            "Thanks for the entry!", preferredStyle: UIAlertControllerStyle.Alert)
        
        let alertEmpty = UIAlertController(title: "Submit Error", message:
            "The question you posted is blank. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
        
        if(responseText.text == "") {
            alertEmpty.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default,handler:nil))
            
            self.presentViewController(alertEmpty, animated: true, completion: nil)
        } else {
            postData()
            
            alertFull.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertFull, animated: true, completion: nil)
            
        }
        
    }
    
    func postData() {
        var url: NSString!{
            return String("https://api.mongolab.com/api/1/databases/4977db/collections/\(course)?q={\"question\": \"\(quest)\"}&apiKey=S5fvstSiHqBeeiQQsvFsvj3AQ2Rw97OL")
        }
        let path : NSURL = NSURL(string: url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)!
        let resp = responseText.text
        response.append(resp)
        
        Alamofire.request(.PUT, path, parameters: ["question" : quest, "response_array" : response], encoding: .JSON)
        
        dispatch_async(dispatch_get_main_queue()){
            self.responseTable.reloadData()
        }
    }
    
    func backtoCoursesPage() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func getResp() {
        self.response = []
    }
    
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMongoData() {
        self.response = []
        var url: NSString!{
            return String("https://api.mongolab.com/api/1/databases/4977db/collections/\(course)?q={\"question\": \"\(quest)\"}&f={\"response_array\":1, \"_id\":0}&apiKey=S5fvstSiHqBeeiQQsvFsvj3AQ2Rw97OL")
        }
        let path : NSURL = NSURL(string: url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)!
        
        Alamofire.request(.GET, path).responseJSON {
            response in switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)

                    for answer in json[0]["response_array"]
                    {
                        //print(String(answer.1))
                        self.response.append(String(answer.1))
                    }
                    dispatch_async(dispatch_get_main_queue()){
                        self.responseTable.reloadData()
                    }
                }
            case .Failure(let error):
                print(error)
            }
        }

    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            responseText.resignFirstResponder()
            return false
        }
        return true
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return response.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ResponseCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        let resp = self.response[indexPath.row]
        
        cell.textLabel?.text = resp
        
        return cell
    }
}