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
