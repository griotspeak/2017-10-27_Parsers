extension Parser {
    static func result(value:Value) -> Parser {
        return Parser { (input) in
            return (value, remainder:input)
        }
    }
}

let parser = Parser<Int>.result(value: 3)
parser.apply("hello")
