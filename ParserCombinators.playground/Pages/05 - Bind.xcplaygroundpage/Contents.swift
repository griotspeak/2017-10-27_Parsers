func bind<T, U>(_ parserT:Parser<T>, lift:@escaping ((T) -> Parser<U>)) -> Parser<U> {
    return Parser<U> { (input) in
        if let (theT, theRemainder) = parserT.apply(input) {
            return lift(theT).apply(theRemainder)
        } else {
            return nil
        }
    }
}

let parser = bind(Parser<Int>.item()) { (firstLetter) -> Parser<Character> in
    return Parser<Int>.item()
}
parser.apply("hello")

