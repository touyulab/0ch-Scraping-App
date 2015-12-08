//
//  responseViewController.swift
//  0ch-Scraping-App
//
//  Created by 秋葉祐人 on 2015/11/29.
//  Copyright © 2015年 秋葉祐人. All rights reserved.
//

import UIKit
import Ji

class responseViewController: UITableViewController {
    
    var delegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var friends:[Friend2] = [Friend2]()
    
    var data = NSMutableArray()
    
    var selectCell: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        sleep(1)
        
        let url = NSURL(string: "http://zeroch.p1ch.jp/nan4r/" + self.delegate.threadID)
        let jiDoc = Ji(htmlURL: url!)
        
        print(jiDoc)
        
        let ulNode = jiDoc?.xPath("//ul")!.first
        // print(ulNode)
        
        // レスの個数
        var responsNum = 0;
        for childulNode in ulNode!.children {
            responsNum++
        }
        
        // print(responsNum)
        
        // let header = jiDoc?.xPath("//header")!.first
        // print(header)
        
        var count = 0;
        
        var header: String = " "
        var response: String = " "
        friends = []
        
        for var i=0; i<responsNum; i++ {
            let li = jiDoc!.xPath("//li[\(i+1)]")!.first
            // print(li)
            
            for childNode in li!.children {
                
                /*
                <header>~~~~</header>
                -------------------
                <p>~~~~</p>
                -------------------
                <header>~~~~</header>
                -------------------
                <p>~~~~</p>
                
                のように帰ってくるため奇数、偶数で場合分け
                */
                // print(childNode)
                // print("-----------------")
                
                
                if count % 2 == 0 {
                    // header
                    
                    header = "\(childNode)"
                    // <header></header>の削除
                    header = header[header.startIndex.advancedBy(15)...header.startIndex.advancedBy((header.characters.count)-10)]
                    
                    // setupFriends("test response")
                    // header.addObject("\(childNode)")
                }
                else {
                    
                    response = "\(childNode)"
                    // <p></p>の削除
                    response = response[response.startIndex.advancedBy(3)...response.startIndex.advancedBy((response.characters.count)-5)]
                    
                    // <br>の削除
                    response = response.stringByReplacingOccurrencesOfString("<br>", withString: "")
                    
                    // <>が違う文字に変換されているのを修正
                    // &lt; = <
                    response = response.stringByReplacingOccurrencesOfString("&lt;", withString: "<")
                    response = response.stringByReplacingOccurrencesOfString("&gt;", withString: ">")
                    
                    // setupFriends("\(childNode)")
                    // response.addObject("\(childNode)")
                }
                
                count++
                
            }
            print(header)
            print(response)
            
            setupFriends(header, response: response)
            
            self.tableView.reloadData()
            
        }
        
    }
    
    // セクションの個数
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    // セクションあたりのセルの個数
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return friends.count
    }
    
    // セル内部の設定
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: responseCell = tableView.dequeueReusableCellWithIdentifier("responseView", forIndexPath: indexPath) as! responseCell
        
        cell.setCell(friends[indexPath.row])
        
        // cell.textLabel!.text = "\(response[indexPath.row])"
        
        return cell
    }
    
    // セルが選択された時の処理
    override func tableView(tableView: UITableView?, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectCell = indexPath.row + 1
        
        let header = friends[indexPath.row].header
        // let response = friends[indexPath.row].response
        
        let alert = UIAlertController(title: "", message: "\(header)", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        alert.addAction(
            UIAlertAction(title: ">>\(selectCell)に返信",
                style: UIAlertActionStyle.Default,
                handler: handlerActionSheet))
        
        alert.addAction(
            UIAlertAction(title: "キャンセル",
                style: UIAlertActionStyle.Cancel,
                handler: handlerActionSheet))
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func handlerActionSheet( ac:UIAlertAction ) -> Void {
        
        switch ac.title! {
        case ">>\(selectCell)に返信":
            self.delegate.response = ">>\(selectCell) "
            performSegueWithIdentifier("ToNewResponseView", sender: nil)
            
            default: print("default")
        }
        
    }
    
    func setupFriends(header: String, response: String) {
        let celldata = Friend2(header: header, response: response)
        
        friends.append(celldata)
    }
    
    
    
}

