//
//  SubmitQuestionViewController.swift
//  TermProject
//
//  Created by Julia Yiu on 2015-11-27.
//  Copyright © 2015 Evanna Wong. All rights reserved.
//

import Alamofire
import UIKit
import SwiftyJSON

class SubmitQuestionViewController: UIViewController {
    var data: String = ""
    var courseName: String = ""
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var questionEntry: UITextView!
    @IBOutlet var submitQuestionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.questionEntry.layer.borderWidth = 0.5
        self.questionEntry.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.questionEntry.layer.cornerRadius = 8
        self.submitButton.layer.cornerRadius = 8
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func postData(){
        let path = "https://api.mongolab.com/api/1/databases/4977db/collections/" + courseName + "?apiKey=S5fvstSiHqBeeiQQsvFsvj3AQ2Rw97OL"
        
        let question = questionEntry.text

        Alamofire.request(.POST, path, parameters: ["question" : question, "response_array": []], encoding: .JSON)
        
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func backtoCoursesPage() {
        //performSegueWithIdentifier("backToCourses", sender: self)
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func submitButton(sender: UIButton) {
        let alertFull = UIAlertController(title: "Question Submitted", message:
            "Thanks for the entry!", preferredStyle: UIAlertControllerStyle.Alert)
        
        let alertEmpty = UIAlertController(title: "Submit Error", message:
            "The question you posted is blank. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
        
        if(questionEntry.text == "") {
            alertEmpty.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default,handler:nil))
            
            self.presentViewController(alertEmpty, animated: true, completion: nil)
        } else {
            postData()
            
            alertFull.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default,handler: {(alertAction) -> Void in self.backtoCoursesPage()}))
            
            self.presentViewController(alertFull, animated: true, completion: nil)
            
        }
    }
}