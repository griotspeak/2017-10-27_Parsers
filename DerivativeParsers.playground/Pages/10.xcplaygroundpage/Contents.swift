//: [Previous](@previous)

extension Recognizer {
    func derive(_ symbol: Character) -> Recognizer {

        let back: Recognizer

        switch algebra {
        case .epsilon:
            back = .null
        case .null:
            back = .null
        case .literal(let symbols):
            guard let (head, tail) = symbols.headAndTail else {
                fatalError("Invalid literal node constructed with empty string.")
            }

            if head == symbol,
                tail.isEmpty {
                back = .epsilon
            } else if head == symbol {
                back = .literal(tail)
            } else {
                back = .null
            }
        }

        return back
    }

    public func apply(_ input: String) -> Bool {
        return apply(input.characters)
    }

    public func apply(_ input: String.CharacterView) -> Bool {

        switch (input.headAndTail, algebra) {
        case (.none, .epsilon):
            return true
        case (.none, .literal), (.none, .null), (.some, .null):
            return false
        case (.some(let head, let tail), _):
            return derive(head).apply(tail)
        default:
            fatalError("Question: How did we get here? Part 2.\n    Answer: input.isEmpty has failed us.")
        }
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

    public static var null: Recognizer {
        return Recognizer(.null)
    }
}

//: [Next](@next)
