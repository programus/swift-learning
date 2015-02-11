//
//  TodayViewController.swift
//  Widget
//
//  Created by 王 元 on 15-01-28.
//  Copyright (c) 2015年 programus. All rights reserved.
//

import Cocoa
import NotificationCenter

class TodayViewController: NSViewController, NCWidgetProviding {

    @IBOutlet weak var nowText: NSTextField!
    
    override var nibName: String? {
        return "TodayViewController"
    }

    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Update your data and prepare for a snapshot. Call completion handler when you are done
        // with NoData if nothing has changed or NewData if there is new data since the last
        // time we called you
        let cal = NSCalendar(calendarIdentifier: NSJapaneseCalendar)
        let now = NSDate()
        let formatter = NSDateFormatter()
        formatter.timeStyle = NSDateFormatterStyle.FullStyle
        self.nowText.stringValue = formatter.stringFromDate(now)
        completionHandler(.NewData)
    }

}
