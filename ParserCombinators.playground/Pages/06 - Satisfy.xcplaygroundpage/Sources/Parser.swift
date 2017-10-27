public struct Parser<Value> {
    public typealias Function = (String) -> (Value, remainder:String)?
    public let apply:Function

    public init(apply: @escaping Function) {
        self.apply = apply
    }
}

extension Parser {
    public static func result(value:Value) -> Parser {
        return Parser { (input) in
            return (value, remainder:input)
        }
    }
}

extension Parser {
    public static func zero() -> Parser {
        return Parser { (input) in
            return nil
        }
    }
}

extension Parser {
    public static func item() -> Parser<Character> {
        return Parser<Character> { (input) in

            let firstIndex = input.startIndex

            if firstIndex == input.endIndex {
                return nil
            } else {
                return (input[firstIndex], remainder: String(input.characters.dropFirst()))
            }
        }
    }
}


public func bind<T, U>(_ parserT:Parser<T>, lift:@escaping ((T) -> Parser<U>)) -> Parser<U> {
    return Parser<U> { (input) in
        if let (theT, theRemainder) = parserT.apply(input) {
            return lift(theT).apply(theRemainder)
        } else {
            return nil
        }
    }
}
