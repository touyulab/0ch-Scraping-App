//
//  newThreadView.swift
//  0ch-Scraping-App
//
//  Created by 秋葉祐人 on 2015/11/30.
//  Copyright © 2015年 秋葉祐人. All rights reserved.
//

import UIKit

class newThreadView: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textField1.delegate = self
        textField2.delegate = self
        textField3.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AddThread(sender: UIButton) {
        
        let title = textField1.text!
        let name = textField2.text!
        let mail = textField3.text!
        let body = textView.text
        
        let post = "title=\(title)&mail=\(mail)&name=\(name)&body=\(body)"
        let postdata = post.dataUsingEncoding(NSUTF8StringEncoding)
        
        print(post)
        print(postdata)
        
        let url = NSURL(string: "http://zeroch.p1ch.jp/nan4r")
        let req = NSMutableURLRequest(URL: url!)
        
        req.HTTPMethod = "POST"
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        req.HTTPBody = postdata
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(req, completionHandler:  {
            (data, res, err) in
            if data != nil {
                let text = NSString(data: data!, encoding: NSUTF8StringEncoding)
                dispatch_async(dispatch_get_main_queue(), {
                    print(text)
                })
            }else {
                dispatch_async(dispatch_get_main_queue(), {
                    self.textView.text = "error"
                })
            }
        })
        task.resume()
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        
        return true
    }
    @IBAction func CancelButton(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
