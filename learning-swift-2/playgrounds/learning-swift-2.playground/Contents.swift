//: Playground - noun: a place where people can play

import UIKit

var hiThere = "Hi there"
hiThere = "Hi there again"

let permanentGreeting = "Hello fine sir"
//permanentGreeting = "Good morning sir"

var timeLeft = 30
var score: Int {
get {
  return timeLeft * 25
}
}

score

struct Book {
  var size = CGSize()
  var numberOfPages = 100
  var price: Float {
    get {
      return Float(CGFloat(numberOfPages) * (size.height * size.width))
    }
    set (newPrice) {
      numberOfPages = Int(newPrice / Float(size.height * size.width))
    }
  }
}

var book = Book(size: CGSize(width: 0.5, height: 0.5), numberOfPages: 400)
book.price

book.price = 400

book.numberOfPages

book.price

0b1100
0o10
010

var pi: Any?
pi = 3.14
pi is Float
pi is Double

var i8: Int8 = 3
var i16: Int16 = 5
i8 + Int8(i16)

var hasSomething: String? = "hi"

if let message = hasSomething {
  message
} else {
  "nothing"
}

hasSomething!

var mustHasSomething: String! = "Hi world"
mustHasSomething

var purchaseEndpoint = (name: "buy", httpMethod: "POST", URL: "/buy/", useAuth: true)
purchaseEndpoint.1
purchaseEndpoint.httpMethod = "GET"

var mixedArray:[AnyObject] = [1, "hi", 3.14, Float(4)]
mixedArray.append("end")
mixedArray.count

var arr = [Int](count: 5, repeatedValue: 3)
var map = [[Int]](count: 5, repeatedValue: [Int](count: 5, repeatedValue: 0))
for row in map {
  print(row)
}
print("====")
var r1 = [Int](count: 4, repeatedValue: 0)
map = [[Int]](count: 3, repeatedValue: r1)
map[2][1] = 3
for row in map {
  print(row)
}
print("====")
map.removeAll()

var d: [String: String?] = ["a": "AA", "b": "BB", "c": nil]
d.count
d
d["a"] = nil
d
d.count

arc4random_uniform(UInt32(10))
