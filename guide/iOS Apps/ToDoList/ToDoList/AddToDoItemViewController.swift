//
//  AddToDoItemViewController.swift
//  ToDoList
//
//  Created by 王 元 on 15-01-18.
//  Copyright (c) 2015年 programus. All rights reserved.
//

import UIKit

class AddToDoItemViewController: UIViewController {
    
    var todoItem: ToDoItem?

    @IBOutlet weak var itemNameText: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (sender as UIBarButtonItem == self.saveButton && countElements(self.itemNameText.text) > 0) {
            self.todoItem = ToDoItem(itemName: self.itemNameText.text)
        }
    }
}
