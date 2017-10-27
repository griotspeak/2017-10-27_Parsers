func choice<T>(_ lhs:Parser<T>, _ rhs:Parser<T>) -> Parser<T> {
    return Parser { (input) in
        if let leftParse = lhs.apply(input) {
            return leftParse
        } else {
            return rhs.apply(input)
        }
    }
}

let parser: Parser<String> = choice(word("OS X"), word("macOS"))

parser.apply("OS X")
parser.apply("macOS")
parser.apply("MACos")
