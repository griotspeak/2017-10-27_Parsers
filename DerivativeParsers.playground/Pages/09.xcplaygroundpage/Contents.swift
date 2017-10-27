//: [Previous](@previous)


extension Recognizer {
    func derive(_ symbol: Character) -> Recognizer {

        let back: Recognizer

        switch algebra {
        case .epsilon:
            fatalError("How do we communicate a bad parse?")
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
                fatalError("How do we communicate a bad parse?")
            }
        }

        return back
    }
}

//: [Next](@next)
