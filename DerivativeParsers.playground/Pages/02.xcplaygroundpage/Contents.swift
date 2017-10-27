//: [Previous](@previous)

extension Ternean {
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

//: [Next](@next)
