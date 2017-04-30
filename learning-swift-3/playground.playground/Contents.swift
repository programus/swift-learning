//: Playground - noun: a place where people can play

import UIKit
import Foundation

// MARK: tuple

let x = (s: "Hello", w: 500, h: 200)
let y: (ss: String, ww: Int, hh: Int) = ("hi", 40, 20)
let (s, w, h) = x
s
w
h

// MARK: String
let str = "0123456789"
str.characters.index(of: "3")

// MARK: NSNumber
let nsn = NSNumber(value: 0.00001)
nsn.intValue
nsn.boolValue
nsn.decimalValue
nsn.doubleValue

let defaults = UserDefaults.standard
