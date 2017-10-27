//: [Previous](@previous)

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
}

//: [Next](@next)
