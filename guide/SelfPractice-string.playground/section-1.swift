// Playground - noun: a place where people can play

// --
// String
// --

// String is a struct, which means passed by value instead of ref.
println("\u{1f425}")

let eAcute: Character = "\u{E9}"                         // é
let combinedEAcute: Character = "\u{65}\u{301}"          // e followed by ́
eAcute == combinedEAcute
countElements("abc")

let latinCapitalLetterA: Character = "\u{41}"
let cyrillicCapitalLetterA: Character = "\u{0410}"
if latinCapitalLetterA != cyrillicCapitalLetterA {
    println("These two characters are not equivalent")
}

let 你好 = "你好"
for codeUnit in 你好.utf16 {
    print("\(codeUnit) ")
}
println()
for codeUnit in 你好.utf8 {
    print("\(codeUnit) ")
}
println()


