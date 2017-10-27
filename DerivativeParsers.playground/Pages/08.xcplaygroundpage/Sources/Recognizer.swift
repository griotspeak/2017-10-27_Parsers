
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

extension String.CharacterView {
    var headAndTail: (Character, String.CharacterView)? {
        if let head = first {
            return (head, dropFirst())
        } else {
            return nil
        }
    }
}

