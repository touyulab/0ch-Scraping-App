//
//  threadViewController.swift
//  0ch-Scraping-App
//
//  Created by 秋葉祐人 on 2015/11/29.
//  Copyright © 2015年 秋葉祐人. All rights reserved.
//

import UIKit
import Ji

class threadViewController: UITableViewController {
    
    var delegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var friends:[Friend] = [Friend]()
    
    let threadTitle = NSMutableArray()
    let threadID = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let green = UIColor(red: 190/255, green: 255/255, blue: 255/255, alpha: 0)
        
        self.navigationController?.navigationBar.barTintColor = green
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        let url = NSURL(string: "http://zeroch.p1ch.jp/nan4r")
        let jiDoc = Ji(htmlURL: url!)
        
        // print(jiDoc)
        
        let ulNode = jiDoc?.xPath("//ul")!.first
        
        // print(ulNode)
        
        // カウント用変数
        var i = 0
        
        friends = []
        
        for childNode in ulNode!.children {
            
            let childNodeStr: String = "\(childNode)"
            
            if let nan4r_position = childNodeStr.rangeOfString("nan4r/") {
                
                // threadIDの始まる位置を検索
                let startID = nan4r_position.endIndex
                // threadIDの終わる位置を設定
                let endID = startID.advancedBy(9)
                
                // threadIDを抽出
                threadID[i] = childNodeStr[startID...endID]
                
            }
            else {
                // IDを抽出出来ないとき
            }
            
            for childNode2 in childNode.children {
                
                // スレッド一覧を取得
                setupFriends(childNode2.content!)
                
                print(childNode2)
                
                // カウント
                i++
            }
        }
        
        self.tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        let cell: CustomCell = tableView.dequeueReusableCellWithIdentifier("tableView", forIndexPath: indexPath) as! CustomCell
        
        cell.setCell(friends[indexPath.row])
        
        return cell
    }
    
    // セルが選択された時の処理
    override func tableView(tableView: UITableView?, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.delegate.threadID = threadID[indexPath.row] as! String
        print(self.delegate.threadID)
        
        performSegueWithIdentifier("ToresponseViewController", sender: nil)
    }
    
    func setupFriends(threadTitle: String) {
        let data = Friend(threadTitle: threadTitle)
        
        friends.append(data)
    }

    
}
