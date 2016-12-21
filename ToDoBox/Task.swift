//
//  Task.swift
//  ToDoBox
//
//  Created by MacBookPro on 2016. 12. 19..
//  Copyright © 2016년 EDCAN. All rights reserved.
//

struct Task{
    var title : String
    var memo : String?
    var done : Bool
    
    init(title : String, memo : String? = nil){
        self.title = title
        self.memo = memo
        self.done = false
    }
}
