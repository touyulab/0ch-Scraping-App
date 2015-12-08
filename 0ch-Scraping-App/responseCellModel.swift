//
//  responseCellModel.swift
//  0ch-Scraping-App
//
//  Created by 秋葉祐人 on 2015/11/29.
//  Copyright © 2015年 秋葉祐人. All rights reserved.
//

import Foundation

class Friend2 : NSObject {
    var header: NSString
    var response: NSString
    
    init(header: String, response: String){
        self.header = header
        self.response = response
    }
}