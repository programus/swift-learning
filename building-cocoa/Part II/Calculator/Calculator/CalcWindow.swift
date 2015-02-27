//
//  CalcWindow.swift
//  Calculator
//
//  Created by 王 元 on 15-02-27.
//  Copyright (c) 2015年 programus. All rights reserved.
//

import Cocoa

class CalcWindow: NSWindow {
    var keyTable = [String: NSButtonCell]()
    let clearKey = "clear"
    let resultKey = "\r"
    
    
    func checkButton(aButton: NSButtonCell) {
        if let title = aButton.title {
            // Check for a cell with a title exactly one character long.
            // Put both uppercase and lowercase into dictionary.
            if countElements(title) == 1 {
                if aButton.tag == -1 {
                    keyTable[clearKey] = aButton
                } else if aButton.tag == Operator.Equals.rawValue {
                    keyTable[resultKey] = aButton
                } else {
                    keyTable[title.uppercaseString] = aButton
                    keyTable[title.lowercaseString] = aButton
                }
            }
        }
        
    }
    
    func checkMatrix(aMatrix: NSMatrix) {
        for cell in aMatrix.cells {
            checkButton(cell as NSButtonCell)
        }
    }
    
    func checkView(aView: NSView) {
        if let button = aView as? NSButton {
            checkButton(button.cell()! as NSButtonCell)
        } else if let matrix = aView as? NSMatrix {
            checkMatrix(matrix)
        } else {
            for view in aView.subviews {
                checkView(view as NSView)
            }
        }
    }
    
    func findButtons() {
        keyTable.removeAll(keepCapacity: true)
        checkView(contentView as NSView)
    }
    
    override func keyDown(theEvent: NSEvent) {
        if let button = keyTable[theEvent.characters!] {
            button.performClick(self)
        } else {
            super.keyDown(theEvent)
        }
    }
    
    override func cancelOperation(sender: AnyObject?) {
        // handle escape key
        if let button = keyTable[clearKey] {
            button.performClick(self)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialFirstResponder = self.contentView as? NSView
    }
    
    override init(contentRect: NSRect, styleMask aStyle: Int, backing bufferingType: NSBackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: aStyle, backing: bufferingType, defer: flag)
        initialFirstResponder = self.contentView as? NSView
    }
}
