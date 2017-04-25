//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 王元 on 2017/4/25.
//  Copyright © 2017年 programus. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equal
    }
    
    struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    var operators = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "+": Operation.binaryOperation(+),
        "−": Operation.binaryOperation(-),
        "×": Operation.binaryOperation(*),
        "÷": Operation.binaryOperation(/),
        "√": Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "+/-": Operation.unaryOperation(-),
        "=": Operation.equal
    ]
    
    private var accumulator: Double?
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    var result: Double? {
        get {
            return self.accumulator
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        self.accumulator = operand
    }
    
    mutating func performOperation(_ symbol: String) {
        guard let operation = self.operators[symbol] else {
            return
        }
        
        switch operation {
        case .constant(let value):
            accumulator = value
        case .unaryOperation(let function):
            if accumulator != nil {
                accumulator = function(accumulator!)
            }
        case .binaryOperation(let function):
            if let operand = accumulator {
                self.pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: operand)
                self.accumulator = nil
            }
        case .equal:
            if self.pendingBinaryOperation != nil && self.accumulator != nil {
                self.accumulator = self.pendingBinaryOperation?.perform(with: self.accumulator!)
                self.pendingBinaryOperation = nil
            }
        }
    }
    
}
