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

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if self.userIsTypingDigit {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsTypingDigit = true
        }
    }
}

