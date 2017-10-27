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
        case epsilon/*will contain values when parsing*/
        case null/*will contain errors when parsing*/
        case union(() -> Recognizer, () -> Recognizer) // `||`
    }

    public static func union(_ lhs: @escaping @autoclosure ()-> Recognizer,
                             _ rhs: @escaping @autoclosure () -> Recognizer) -> Recognizer {
        return .union(lhs, rhs)
    }
}

//: [Next](@next)
