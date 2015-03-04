//
//  PagerContoller.swift
//  MathPaper
//
//  Created by 王 元 on 15-03-03.
//  Copyright (c) 2015年 programus. All rights reserved.
//

import Cocoa

class PagerContoller: NSWindowController {
    var evaluator: NSTask!
    var toPipe: NSPipe!
    var fromPipe: NSPipe!
    var toEvaluator: NSFileHandle!
    var fromEvaluator: NSFileHandle!
    
    let separator = "------\n"
    
    @IBOutlet var theText: NSTextView!

    override func windowDidLoad() {
        super.windowDidLoad()
    
        if let win = self.window {
            win.makeFirstResponder(theText)
        }
        
        let exePath = "/usr/bin/bc"
        let initScriptPath = NSBundle.mainBundle().pathForResource("init.bc", ofType: nil)
        
        toPipe = NSPipe()
        fromPipe = NSPipe()
        toEvaluator = toPipe.fileHandleForWriting
        fromEvaluator = fromPipe.fileHandleForReading
        
        evaluator = NSTask()
        evaluator.launchPath = exePath
        evaluator.standardOutput = fromPipe
        evaluator.standardError = fromPipe
        evaluator.standardInput = toPipe
        var arguments = ["-l", "-q"]
        if let path = initScriptPath {
            arguments.append(path)
        }
        evaluator.arguments = arguments
        evaluator.launch()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "gotData:", name: NSFileHandleReadCompletionNotification, object: fromEvaluator)
        fromEvaluator.readInBackgroundAndNotify()
    }
    
    func textDidChange(notification: NSNotification) {
        if let key = self.window?.currentEvent?.characters {
            if key == "\r" {
                if let text = theText.string {
                    let length = countElements(text)
                    
                    for var i = text.endIndex; i != text.startIndex; i = i.predecessor() {
                        if i == text.startIndex.successor() || text[i.predecessor().predecessor()] == Character("\n") {
                            let lastLine = text.substringFromIndex(i.predecessor())
                            if countElements(lastLine) > 1 && lastLine != separator {
                                if let data = lastLine.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true) {
                                    toEvaluator.writeData(data)
                                    theText.editable = text.rangeOfString("=") != nil
                                }
                            }
                            break
                        }
                    }
                }
            }
        }
    }
    
    deinit {
        evaluator.terminate()
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func gotData(notification: NSNotification) {
        if let data: NSData = notification.userInfo?[NSFileHandleNotificationDataItem] as? NSData {
            if let str = NSString(data: data, encoding: NSASCIIStringEncoding) {
                theText.replaceCharactersInRange(NSMakeRange(theText.textStorage!.length, 0), withString: str)
                theText.replaceCharactersInRange(NSMakeRange(theText.textStorage!.length, 0), withString: separator)
                theText.scrollRangeToVisible(NSMakeRange(theText.textStorage!.length, 0))
            }
        }
        
        fromEvaluator.readInBackgroundAndNotify()
        theText.editable = true
    }

}
