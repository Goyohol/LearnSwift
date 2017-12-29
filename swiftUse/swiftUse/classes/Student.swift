//
//  Student.swift
//  swiftUse
//
//  Created by RainHeroic Kung on 2017/12/20.
//  Copyright © 2017年 RainHeroic Kung. All rights reserved.
//

import UIKit

class Student: NSObject {
    
    var studname: String
    var mark: Int
    var mark2: Int
    
    
//    override init() { //设置好 初始的值
//        self.studname = ""
//        self.mark = 0
//        self.mark2 = 0
//        
//    }
    
    init(studname: String,mark: Int,mark2: Int) {
        self.studname = studname
        self.mark = mark
        self.mark2 = mark2
    }
    
}



