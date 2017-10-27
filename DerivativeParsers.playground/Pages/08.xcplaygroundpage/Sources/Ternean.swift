public enum Ternean {
    case yes
    case no
    case maybe

    public func and(_ other: Ternean) -> Ternean {
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

    public func or(_ other: Ternean) -> Ternean {
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
