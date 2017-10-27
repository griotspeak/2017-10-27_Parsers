public final class Recognizer {
    public let algebra: Algebra

    public init(_ algebra: Algebra) {
        self.algebra = algebra
    }
}

extension Recognizer {
    public enum Algebra {
        case literal(String.CharacterView)
        case epsilon/*will contain values when parsing*/
        case null/*will contain errors when parsing*/
    }
}

// MARK: -
extension String.CharacterView {
    public var headAndTail: (Character, String.CharacterView)? {
        if let head = first {
            return (head, dropFirst())
        } else {
            return nil
        }
    }
}
