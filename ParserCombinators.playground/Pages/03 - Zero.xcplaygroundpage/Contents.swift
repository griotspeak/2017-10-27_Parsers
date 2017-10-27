extension Parser {
    static func zero() -> Parser {
        return Parser { (input) in
            return nil
        }
    }
}

let parser = Parser<Int>.zero()
parser.apply("hello")
