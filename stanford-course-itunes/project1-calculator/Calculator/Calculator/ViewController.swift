//
//  ViewController.swift
//  Calculator
//
//  Created by Programus on 15/4/11.
//  Copyright (c) 2015年 Programus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsTypingDigit = false
    
    var brain = CalculatorBrain()
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsTypingDigit = false
        }
    }

    @IBAction func operate(sender: UIButton) {
        if userIsTypingDigit {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if self.userIsTypingDigit {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsTypingDigit = true
        }
    }
    
    @IBAction func enter() {
        userIsTypingDigit = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
}

