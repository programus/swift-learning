// Playground - noun: a place where people can play

// --
// Collections
// --

// remove a range.
var array = [1, 4, 6, 2, 3]
var start = 1
var stop = 3
array[start..<stop] = []
array
array += [9, 8, 6]

// iteration with index
for (i, v) in enumerate(array) {
    println("array[\(i)]: \(v)")
}

// init with count: argument name is necessary.
var threeDoubles = [Double](count: 3, repeatedValue: 0.0)

// use custom type as dictionary key
class CustKey: Hashable, Printable {
    var value: Int
    var hashValue: Int {
        return self.value
    }
    var description: String {
        return "CK[\(self.value)]"
    }
    init(_ value: Int) {
        self.value = value
    }
}

func == (lhs: CustKey, rhs: CustKey) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

var custDict = [CustKey(1): 1, CustKey(2): 2, CustKey(9): 9]

for i in 0...9 {
    var k = CustKey(i)
    if var v = custDict[k] {
        println("Got \(v)|same ref:\(k === CustKey(i))|same content:\(k == CustKey(i))")
    }
}

let keys = [CustKey](custDict.keys)

