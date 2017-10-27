//: [Previous](@previous)

public final class Recognizer {
    public let algebra: Algebra

    public init(_ algebra: Algebra) {
        self.algebra = algebra
    }
}

extension Recognizer {
    enum Algebra {
        case literal(String.CharacterView)
        case epsilon/*will contain values when parsing*/
        case null/*will contain errors when parsing*/
    }
}

extension Recognizer {
    public static var null: Recognizer {
        return Recognizer(.null)
    }
}

//: [Next](@next)
