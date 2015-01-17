// Playground - noun: a place where people can play

// --
// enum
// --

enum CompassPoint {
    case North
    case South
    case East
    case West
}

var dir = CompassPoint.East

dir = .West

switch (dir) {
case .North:
    println("N")
case .South:
    println("S")
case .West:
    println("W")
case .East:
    println("E")
default:
    println("?")
}

enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}

var code = Barcode.QRCode("ABC")
code = Barcode.UPCA(8, 85909, 51226, 3)

switch (code) {
case let .UPCA(numberSystem, manufacturer, product, check):
    println("UPC-A: \(numberSystem) \(manufacturer) \(product) \(check)")
case let .QRCode(productCode):
    println("QR code: \(productCode)")
}
