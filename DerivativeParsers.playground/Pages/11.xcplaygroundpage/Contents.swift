//: [Previous](@previous)

enum Ternean {
    case yes
    case no
    case maybe

    func and(_ other: Ternean) -> Ternean {
        switch (self, other) {
        case (.yes, .yes):
            return .yes
        case (.no, _), (_, .no):
            return .no
        case (.maybe, _), (_, .maybe):
            return .maybe
        default:
            fatalError("How did we get here? Part 1.")
        }
    }

    func or(_ other: Ternean) -> Ternean {
        switch (self, other) {
        case (.yes, .yes):
            return .yes
        case (.yes, .no):
            return .no
        case (.yes, .maybe):
            return .maybe
        case (.no, .yes):
            return .yes
        case (.no, .no):
            return .no
        case (.no, .maybe):
            return .maybe
        case (.maybe, .yes):
            return .yes
        case (.maybe, .no), (.maybe, .maybe):
            return .maybe
        }
    }
}

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

let ab: Recognizer = .literal("ab")
ab.apply("aa")
ab.apply("ab")
ab.apply("")


//: [Next](@next)
