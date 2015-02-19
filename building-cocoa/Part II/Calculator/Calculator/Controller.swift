//
//  Controller.swift
//  Calculator
//
//  Created by Programus on 15-02-15.
//  Copyright (c) 2015 programus. All rights reserved.
//

import Cocoa

@NSApplicationMain
class Controller: NSObject, NSApplicationDelegate {
    enum Operator: Int {
        case None       = 0
        case Plus       = 1001
        case Subtract   = 1002
        case Multiply   = 1003
        case Divide     = 1004
        case Equals     = 1005
    }
    
    var x = 0.0
    var y = 0.0
    var enterFlag = false
    var yFlag = false
    var operation = Operator.None
    var radix = 0
    
    
    @IBOutlet weak var readout: NSTextField!
    @IBOutlet weak var radixPopUp: NSPopUpButton!
    
    @IBOutlet var aboutPanel: NSPanel!
    
    func displayX() {
        var s:NSString!
        switch radix {
        case 2:
            s = self.ltob(Int(x))
        case 8:
            s = NSString(format: "%o", Int(x))
        case 10:
            s = NSString(format: "%15.10g", self.x)
        case 16:
            s = NSString(format: "%x", Int(x))
        default:
            s = "0"
        }
        self.readout.stringValue = s
    }
    
    func ltob(var v: Int) -> String {
        var ca = [Character](count: 32, repeatedValue: "0")
        for i in 0..<ca.count {
            if (v >> i) & 1 == 1 {
                ca[ca.count - i - 1] = "1"
            }
        }
        return String(ca)
    }
    
    @IBAction func clear(sender: AnyObject) {
        self.x = 0.0
        self.displayX()
    }
    
    @IBAction func clearAll(sender: AnyObject) {
        self.x = 0.0
        self.y = 0.0
        self.yFlag = false
        self.enterFlag = false
        self.displayX()
    }
    
    @IBAction func selectRadix(sender: NSPopUpButton) {
        if let item = sender.selectedItem {
            self.radix = item.tag
            self.displayX()
        }
    }
    
    @IBAction func enterDigit(sender: AnyObject) {
        if self.enterFlag {
            y = x
            x = 0.0
            enterFlag = false
        }
        
        if let cell: AnyObject = sender.selectedCell() {
            x = x * Double(radix) + Double(cell.tag())
        }
        self.displayX()
    }
    
    @IBAction func doUnaryMinus(sender: AnyObject) {
        x = -x
        self.displayX()
    }
    
    @IBAction func enterOp(sender: AnyObject) {
        if yFlag {
            switch operation {
            case .Plus:
                x = y + x
            case .Subtract:
                x = y - x
            case .Multiply:
                x = y * x
            case .Divide:
                x = y / x
            default:
                break
            }
        }
        y = x
        yFlag = true
        
        operation = Operator(rawValue: sender.selectedCell()!.tag())!
        enterFlag = true
        
        self.displayX()
    }
    
    @IBAction func showAboutPanel(sender: AnyObject) {
        if aboutPanel == nil {
            if !NSBundle.mainBundle().loadNibNamed("AboutPanel", owner: self, topLevelObjects: nil) {
                NSLog("Load of AboutPanel.xib failed")
                return
            }
        }
        
        aboutPanel.floatingPanel = true
        aboutPanel.makeKeyAndOrderFront(nil)
    }
}

extension Controller {
    func applicationDidFinishLaunching(notification: NSNotification) {
        if let item = radixPopUp.selectedItem {
            radix = item.tag
        }
        self.clearAll(self)
    }
}
