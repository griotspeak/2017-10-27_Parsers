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
}

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
        case .union(let lhs, let rhs):
            let left = lhs()
            let right = rhs()
            // it is–in fact–more complicated than this, dear traveller. Please forgive me.
            back = .union(left.derive(symbol), right.derive(symbol))
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

    public static func union(_ lhs: @escaping @autoclosure ()-> Recognizer,
                             _ rhs: @escaping @autoclosure () -> Recognizer) -> Recognizer {
        return Recognizer(.union(lhs, rhs))
    }
}

// MARK: -
extension String.CharacterView {
    var headAndTail: (Character, String.CharacterView)? {
        if let head = first {
            return (head, dropFirst())
        } else {
            return nil
        }
    }
}

//: [Next](@next)
