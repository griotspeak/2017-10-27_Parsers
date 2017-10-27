public final class Recognizer {
    public let algebra: Algebra

    public init(_ algebra: Algebra) {
        self.algebra = algebra
    }
}

extension Recognizer {
    public enum Algebra {
        case literal(String.CharacterView)
    }
}
