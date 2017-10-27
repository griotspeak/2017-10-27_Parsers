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
}
