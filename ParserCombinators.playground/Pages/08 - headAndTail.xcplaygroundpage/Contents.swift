func headAndTail(_ input:String) -> (head:Character, tail:String)? {
    if let head = input.first {
        return (head, String(input.dropFirst()))
    } else {
        return nil
    }
}

headAndTail("SwiftByNorthwest")

