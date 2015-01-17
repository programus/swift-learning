// Playground - noun: a place where people can play

// --
// class & struct
// --

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

func half(inout res: Resolution) {
    res.width >>= 1
    res.height >>= 1
}

var res = Resolution(width: 1024, height: 768)
half(&res)
println("res: \(res.width) x \(res.height)")

var vm = VideoMode()
vm.resolution = res
vm.frameRate = 25



class LazySample {
    lazy var lvm = vm.frameRate
    var vvm = vm.frameRate
}

let ls = LazySample()

vm.frameRate = 30

println(ls.lvm)
println(ls.vvm)

class DidSetSample {
    var half: Int = 0 {
        didSet {
            half = half >> 1
        }
    }
}

var ds = DidSetSample()
ds.half = 5

