//
//  ViewController.swift
//  Calculator
//
//  Created by 王元 on 2017/4/25.
//  Copyright © 2017年 programus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var result: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var brain = CalculatorBrain()
    
    var userIsInTheMiddleOfTyping = false
    
    var resultValue: Double {
        get {
            if let text = self.result.text, let res = Double(text) {
                return res
            } else {
                return 0
            }
        }
        set {
            self.result.text = String(newValue)
        }
    }

    @IBAction func touchDigit(_ sender: UIButton) {
        guard let digit = sender.currentTitle else {
            return
        }
        
        if self.userIsInTheMiddleOfTyping {
            self.result.text?.append(digit)
        } else {
            self.result.text = digit
            self.userIsInTheMiddleOfTyping = true
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        if self.userIsInTheMiddleOfTyping {
            self.brain.setOperand(self.resultValue)
            self.userIsInTheMiddleOfTyping = false
        }
        if let operation = sender.currentTitle {
            self.brain.performOperation(operation)
        }
        if let result = self.brain.result {
            self.resultValue = result
        }
    }
}

