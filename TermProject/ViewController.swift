//
//  ViewController.swift
//  TermProject
//
//  Created by Evanna Wong on 2015-11-09.
//  Copyright © 2015 Evanna Wong. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var studentNoText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func verifyUser() {
        let studentNo:String = studentNoText.text!
        let password:String = passwordText.text!
        
        let path = "https://api.mongolab.com/api/1/databases/comp4977project/collections/Student"
        
        Alamofire.request(.GET, path, parameters: ["apiKey": "QNwCXLgMzmjtezI0ZIubDsy0QZkKdWAX", "q" : "{'Password':'\(password)', 'StudentNo': '\(studentNo)'}"])
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        
                        let json = JSON(value)
                        if(json[0] != nil){
                            self.performSegueWithIdentifier("loginSuccess", sender: self)
                        } else {
                            self.errorLabel.text = "Invalid credential, please try again."
                        }

                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }

    @IBAction func login(sender: AnyObject) {
        verifyUser()
        

    }
}

