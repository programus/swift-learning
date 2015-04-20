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
        
        // initialize document
        if let doc = self.document as? MathDocument {
            let textStorage = theText.textStorage!
            textStorage.beginEditing()
            textStorage.setAttributedString(doc.history)
            textStorage.endEditing()
            if let frame = doc.frame {
                window!.setFrame(frame, display: true)
            }
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
    
    override func windowTitleForDocumentDisplayName(displayName: String) -> String {
        return "MathPaper: \(displayName)"
    }
    
    func textDidChange(notification: NSNotification) {
        if let key = self.window?.currentEvent?.characters {
            if let doc = document as? MathDocument {
                doc.updateChangeCount(NSDocumentChangeType.ChangeDone)
            }
            if key == "\r" {
                if let text = theText.string {
                    let length = count(text)
                    
                    for var i = text.endIndex; i != text.startIndex; i = i.predecessor() {
                        if i == text.startIndex.successor() || text[i.predecessor().predecessor()] == Character("\n") {
                            let lastLine = text.substringFromIndex(i.predecessor())
                            if count(lastLine) > 1 && lastLine != separator {
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
                appendResult(str as String)
                theText.scrollRangeToVisible(NSMakeRange(theText.textStorage!.length, 0))
            }
        }
        
        fromEvaluator.readInBackgroundAndNotify()
        theText.editable = true
    }
    
    func appendResult(result: String) {
        if let textStorage = theText.textStorage {
            let align = NSMutableParagraphStyle()
            align.alignment = NSTextAlignment.RightTextAlignment
            let font = NSFont.boldSystemFontOfSize(20)
            let attrs = [
                NSFontAttributeName: font,
                NSParagraphStyleAttributeName: align
            ]
            
            let attrStr = NSAttributedString(string: result, attributes: attrs)
            let oldAttrs = textStorage.attributesAtIndex(0, effectiveRange: nil)
            
            textStorage.beginEditing()
            textStorage.appendAttributedString(attrStr)
            textStorage.appendAttributedString(NSAttributedString(string: separator, attributes: oldAttrs))
            textStorage.endEditing()
        }
    }
    
    func synchronizeData() {
        if let doc = document as? MathDocument {
            doc.history = theText.textStorage!
            doc.frame = window!.frame
        }
    }

}

extension NSTextView {
    func appendString(str: String) {
        if let len = self.textStorage?.length {
            self.replaceCharactersInRange(NSMakeRange(len, 0), withString: str)
        }
    }
}