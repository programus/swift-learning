//
//  Document.swift
//  MathPaper
//
//  Created by 王 元 on 15-02-28.
//  Copyright (c) 2015年 programus. All rights reserved.
//

import Cocoa

class MathDocument: NSDocument, NSCoding {
    
    var frame: NSRect!
    var history: NSAttributedString!
    
    override init() {
        super.init()
        
        // init the prompt
        let inputAttr = [NSFontAttributeName: NSFont.systemFontOfSize(12)]
        let promptAttr = [NSFontAttributeName: NSFont.boldSystemFontOfSize(10)]
        let prompt = NSMutableAttributedString(string: "", attributes: inputAttr)
        prompt.beginEditing()
        prompt.appendAttributedString(NSAttributedString(string: "Enter a math expression and hit return:", attributes: promptAttr))
        prompt.appendAttributedString(NSAttributedString(string: "\n", attributes: inputAttr))
        prompt.endEditing()
        history = prompt
    }

    override func windowControllerDidLoadNib(aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
        // Add any code here that needs to be executed once the windowController has loaded the document's window.
    }
    
    override func makeWindowControllers() {
        let ctl = PagerContoller(windowNibName: self.windowNibName!)
        self.addWindowController(ctl)
    }

    override class func autosavesInPlace() -> Bool {
        return true
    }

    override var windowNibName: String? {
        // Returns the nib file name of the document
        // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this property and override -makeWindowControllers instead.
        return "PaperWindow"
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeRect(frame)
        aCoder.encodeObject(history)
    }
    
    required init(coder aDecoder: NSCoder) {
        frame = aDecoder.decodeRect()
        if let attributedString = aDecoder.decodeObject() as? NSAttributedString {
            history = attributedString
        }
    }

    override func dataOfType(typeName: String, error outError: NSErrorPointer) -> NSData? {
        if typeName == "MathPaper.MathPaper" {
            for element in windowControllers {
                if let ctrl = element as? PagerContoller {
                    ctrl.synchronizeData()
                }
            }
            return NSArchiver.archivedDataWithRootObject(self)
        }
        outError.memory = NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        return nil
    }

    override func readFromData(data: NSData, ofType typeName: String, error outError: NSErrorPointer) -> Bool {
        if typeName == "MathPaper.MathPaper" {
            if let temp = NSUnarchiver.unarchiveObjectWithData(data) as? MathDocument {
                frame = temp.frame
                history = temp.history
                return true
            }
        }
        outError.memory = NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        return false
    }


}

