//
//  ToDoListTableViewController.swift
//  ToDoList
//
//  Created by 王 元 on 15-01-18.
//  Copyright (c) 2015年 programus. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController {
    
    let numberOfSections = 1
    let cellPrototypeName = "ListPrototypeCell"
    
    var todoItems = [ToDoItem]()
    
    @IBAction
    func unwindToList(segue: UIStoryboardSegue) {
        let source = segue.sourceViewController as AddToDoItemViewController
        if let item = source.todoItem {
            self.todoItems.append(item)
            self.tableView.reloadData()
        }
    }
    
    func getInstallationDate() -> NSDate {
        var date: NSDate!
        if let sourceFile = NSBundle.mainBundle().resourcePath?.stringByAppendingPathComponent("Info.plist") {
            var err: NSError?
            var attrs = NSFileManager.defaultManager().attributesOfItemAtPath(sourceFile, error: &err) as Dictionary?
            if let attr = attrs {
                date = attr[NSFileModificationDate] as NSDate
            } else {
                date = NSDate()
            }
        } else {
            date = NSDate()
        }
        return date
    }
    
    func loadInitialData() {
        self.todoItems.append(ToDoItem(itemName: "Learn how to use To-Do List", creationDate: self.getInstallationDate()))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadInitialData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return self.numberOfSections
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return self.todoItems.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellPrototypeName, forIndexPath: indexPath) as UITableViewCell

        let item = self.todoItems[indexPath.row]
        cell.textLabel?.text = item.itemName
        cell.detailTextLabel?.text = "\(item.creationDate)"
        cell.accessoryType = item.completed ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // deselect immediately
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        // get tapped item
        let item = self.todoItems[indexPath.row]
        // toggle complete
        item.completed = !item.completed
        // reload the data
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
