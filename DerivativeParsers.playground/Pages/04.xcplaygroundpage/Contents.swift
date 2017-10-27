//: [Previous](@previous)
public final class Recognizer {
    let algebra: Algebra

    fileprivate init(_ algebra: Algebra) {
        self.algebra = algebra
    }
}

extension Recognizer {
    enum Algebra {
        case literal(String.CharacterView)
    }
}

//: [Next](@next)
