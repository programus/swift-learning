var optionalString: String? = "Hello"
optionalString == nil
 
var optionalName: String? = "John Appleseed"
// optionalName = nil
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello, \(name)"
}
