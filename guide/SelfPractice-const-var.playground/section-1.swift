// Playground - noun: a place where people can play

//import Cocoa

// --
// constants & variables
// --

var `Int` = 3
println(`Int`)

UInt.min
UInt.max
UInt8.max
UInt16.max
UInt32.max
UInt64.max

let bigX = 1_23_456_789.111_11_1_1
let phone = 123_4567_0809

var byte: UInt8 = 3
var summary: UInt16 = 4 + UInt16(byte)

var doubleX = 3.4 + Double(byte)

let tupleSample = (404, "HTTP Error", "Not Found")
tupleSample.0

let possibleNumber = "00234"
let convertNumber = possibleNumber.toInt()

if convertNumber != nil {
    println("Converted \"\(possibleNumber)\" to \(convertNumber!)")
}

if var n = convertNumber {
    println("Converted \"\(possibleNumber)\" to \(n)")
    println("reduce one -> \(--n)")
} else {
    println("\"\(possibleNumber)\" is not a number")
}
