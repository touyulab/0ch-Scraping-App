//
//  responseCell.swift
//  0ch-Scraping-App
//
//  Created by 秋葉祐人 on 2015/11/29.
//  Copyright © 2015年 秋葉祐人. All rights reserved.
//

import UIKit

class responseCell: UITableViewCell {
    
    @IBOutlet weak var headerView: UILabel!
    @IBOutlet weak var responseView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(friend :Friend2) {
        
        headerView.text = friend.header as String
        
        // URLリンク判定
        responseView.dataDetectorTypes = UIDataDetectorTypes.All
        // 編集不可
        responseView.editable = false
        responseView.text = friend.response as String
        
    }
}