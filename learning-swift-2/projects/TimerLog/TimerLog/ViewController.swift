//
//  ViewController.swift
//  TimerLog
//
//  Created by 王元 on 16/7/3.
//  Copyright © 2016年 programus. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var timerLabel: UILabel!
  @IBOutlet weak var timerCtrlButton: UIButton!
  @IBOutlet weak var studySessionTable: UITableView!
  
  var timer: NSTimer!
  var paused = false
  var timeLeft = 0
  var defaultTimeLeft = 10
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    studySessionTable.delegate = self
    studySessionTable.dataSource = self
    changeStartButtion()
    timeLeft = defaultTimeLeft
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return StudySessionManager.sharedInstance.sessions.count
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let sessionCount = StudySessionManager.sharedInstance.sessions.count
    let sessionsPlural = sessionCount > 1 ? "s" : ""
    return "\(sessionCount) study session\(sessionsPlural)"
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = studySessionTable.dequeueReusableCellWithIdentifier("studySessionCell")!
    let dateDiff = NSDate().timeIntervalSince1970 - StudySessionManager.sharedInstance.sessions[indexPath.row].createAt
    var formattedTime = NSDateComponentsFormatter().stringFromTimeInterval(dateDiff)!
    if formattedTime.rangeOfString(":") == nil {
      formattedTime = "\(formattedTime) seconds ago"
    } else {
      formattedTime = "\(formattedTime) ago"
    }
    cell.textLabel?.text = formattedTime
    return cell
  }
  
  func changeStartButtion() {
    timerCtrlButton.clipsToBounds = true
    timerCtrlButton.layer.cornerRadius = timerCtrlButton.frame.size.width / 2
    timerCtrlButton.layer.borderWidth = 1
    timerCtrlButton.layer.borderColor = paused ? UIColor.redColor().CGColor : UIColor.greenColor().CGColor
    timerCtrlButton.setTitle(paused ? "Paused" : "Start", forState: .Normal)
    timerCtrlButton.setTitleColor(paused ? UIColor.redColor() : UIColor.greenColor(), forState: .Normal)
    
    paused = !paused
    
  }
  
  func timerTick(timer:NSTimer) {
    timeLeft -= 1
    if timeLeft > 0 {
      let seconds = Int(timeLeft % 60)
      let minutes = Int((timeLeft / 60) % 60)
      timerLabel.text = "\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
    } else {
      timeLeft = defaultTimeLeft
      timerLabel.text = "00:00"
      changeStartButtion()
      StudySessionManager.sharedInstance.sessions.insert(StudySession(createAt: timer.userInfo as! NSTimeInterval, finishedAt: NSDate().timeIntervalSince1970), atIndex: 0)
      studySessionTable.reloadData()
      timer.invalidate()
    }
  }

  @IBAction func timerCtrlTapped(sender: AnyObject) {
    if paused {
      timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.timerTick(_:)), userInfo: NSDate().timeIntervalSince1970, repeats: true)
    } else {
      timer.invalidate()
    }
    
    changeStartButtion()
  }

}

