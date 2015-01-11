// Playground - noun: a place where people can play

// --
// functions
// --

func someFunc() {
}

func someFunc(p: String) {
    println(p)
}

someFunc()
someFunc("hello")

func paramWithName(p1: String = "p1", #p2: String) {
    println(p1)
    println(p2)
}

paramWithName(p2: "pp2")

func swap(inout a: Int, inout b: Int) {
    let t = a
    a = b
    b = t
}

var x = 3, y = 5
swap(&x, &y)
x
y

var prl: () -> Void = println
prl()

