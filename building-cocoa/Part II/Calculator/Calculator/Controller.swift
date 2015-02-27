//
//  Controller.swift
//  Calculator
//
//  Created by Programus on 15-02-15.
//  Copyright (c) 2015 programus. All rights reserved.
//

import Cocoa

enum Operator: Int {
    case None       = 0
    case Plus       = 1001
    case Subtract   = 1002
    case Multiply   = 1003
    case Divide     = 1004
    case Equals     = 1005
}

@NSApplicationMain
class Controller: NSObject, NSApplicationDelegate {
    var x = 0.0
    var y = 0.0
    var enterFlag = false
    var yFlag = false
    var operation = Operator.None
    var radix = 0
    
    @IBOutlet weak var readout: NSTextField!
    @IBOutlet weak var radixPopUp: NSPopUpButton!
    @IBOutlet weak var keyPad: NSMatrix!
    
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
    
    func setHexWindow(toHex: Bool) {
        let ysize = (keyPad.cellSize.height + keyPad.intercellSpacing.height) * 2
        if let win = keyPad.window {
            var frame = win.frame
            if toHex {
                frame.size.height += ysize
                frame.origin.y -= ysize
                win.setFrame(frame, display: true, animate: true)
                
                for row in 0...1 {
                    keyPad.insertRow(0)
                    for col in 0...2 {
                        let val = 10 + row * 3 + col
                        let cell = keyPad.cellAtRow(0, column: col) as NSButtonCell
                        cell.tag = val
                        cell.title = NSString(format: "%X", val)
                    }
                }
                keyPad.sizeToCells()
                keyPad.setNeedsDisplay()
            } else {
                frame.size.height -= ysize
                frame.origin.y += ysize
                for row in 0...1 {
                    keyPad.removeRow(0)
                }
                keyPad.sizeToCells()
                keyPad.setNeedsDisplay()
                win.setFrame(frame, display: true, animate: true)
            }
        }
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
            let oldRadix = radix
            self.radix = item.tag
            
            if oldRadix != radix && (oldRadix == 16 || radix == 16) {
                self.setHexWindow(radix == 16)
            }
            
            for cell in self.keyPad.cells {
                let buttonCell = cell as NSButtonCell
                buttonCell.enabled = buttonCell.tag < self.radix
            }
            
            self.displayX()
            
            (keyPad.window as CalcWindow).findButtons()
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
        (keyPad.window as CalcWindow).findButtons()
    }
}
