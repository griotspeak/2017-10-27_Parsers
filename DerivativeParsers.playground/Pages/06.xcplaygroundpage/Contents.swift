//: [Previous](@previous)

extension Recognizer {
    enum Algebra {
        case literal(String.CharacterView)
        case epsilon/*will contain values when parsing*/
    }
}

extension Recognizer {
    public static func literal(_ string: String) -> Recognizer {
        return literal(string.characters)
    }

    public static func literal(_ string: String.CharacterView) -> Recognizer {
        guard string.isEmpty == false else {
            fatalError("literal empty string is epsilon. Use epsilon instead.")
        }
        return Recognizer(.literal(string))
    }

    public static var epsilon: Recognizer {
        return Recognizer(.epsilon)
    }
}

//: [Next](@next)
