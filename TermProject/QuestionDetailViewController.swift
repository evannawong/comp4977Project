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

class QuestionDetailViewController: UIViewController {
    var data = Entry(question: "")
    var quest: String = ""
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var responseText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.responseText.layer.borderWidth = 0.5
        self.responseText.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.responseText.layer.cornerRadius = 8
        //self.responseText.becomeFirstResponder()
        
        //questionLabel = Entry.data
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMongoData() {
    
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            responseText.resignFirstResponder()
            return false
        }
        return true
    }
}