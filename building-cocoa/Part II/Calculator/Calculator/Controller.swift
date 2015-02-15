//
//  Controller.swift
//  Calculator
//
//  Created by Programus on 15-02-15.
//  Copyright (c) 2015 programus. All rights reserved.
//

import Cocoa

class Controller: NSObject {
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
    
    
    @IBOutlet weak var readout: NSTextField!
    
    func displayX() {
        var s = NSString(format: "%15.10g", self.x)
        self.readout.stringValue = s
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
    
    @IBAction func enterDigit(sender: AnyObject) {
        if self.enterFlag {
            y = x
            x = 0.0
            enterFlag = false
        }
        
        if let cell: AnyObject = sender.selectedCell() {
            x = x * 10.0 + Double(cell.tag())
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
}
