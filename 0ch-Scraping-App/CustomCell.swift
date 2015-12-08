//
//  CustomCell.swift
//  0ch-Scraping-App
//
//  Created by 秋葉祐人 on 2015/11/29.
//  Copyright © 2015年 秋葉祐人. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var threadTitleLable: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(friend :Friend) {
        
        threadTitleLable.text = friend.threadTitle as String
        
    }
}