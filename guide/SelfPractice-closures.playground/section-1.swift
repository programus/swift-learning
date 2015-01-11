// Playground - noun: a place where people can play

// --
// closures
// --

let names = ["Tom", "Jerry", "Droopy", "Snoopy", "Doraemon"]

var reversed = sorted(names, {(s1: String, s2: String) -> Bool in
    return s1 > s2
})
reversed = sorted(names,
    {s1, s2 in return s1 > s2})
reversed = sorted(names,
    {s1, s2 in s1 > s2})
reversed = sorted(names,
    {$0 > $1})
reversed = sorted(names, > )
reversed = sorted(names) {
    $0 > $1
}

