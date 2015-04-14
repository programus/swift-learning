//
//  ViewController.swift
//  Calculator
//
//  Created by 王元 on 15/4/11.
//  Copyright (c) 2015年 Programus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsTypingDigit = false
    
    var operandStack = Array<Double>()
    
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
        let operation = sender.currentTitle!
        if userIsTypingDigit {
            enter()
        }
        switch operation {
        case "×":
            performOperation {$0 * $1}
        case "÷":
            performOperation {$1 / $0}
        case "+":
            performOperation {$0 + $1}
        case "−":
            performOperation {$1 - $0}
        case "√":
            performUnaryOperation {sqrt($0)}
        default:
            break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performUnaryOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
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
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }
}

