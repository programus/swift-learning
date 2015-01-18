//
//  ToDoItem.swift
//  ToDoList
//
//  Created by 王 元 on 15-01-18.
//  Copyright (c) 2015年 programus. All rights reserved.
//

import UIKit

class ToDoItem: NSObject {
    var itemName: String!
    var completed: Bool = false
    private(set) var creationDate: NSDate!
    
    init(itemName: String) {
        self.itemName = itemName
        
    }
}
