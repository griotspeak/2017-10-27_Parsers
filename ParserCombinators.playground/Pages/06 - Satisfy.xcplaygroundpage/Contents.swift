func satisfy(predicate:@escaping ((Character) -> Bool)) -> Parser<Character> {
    return bind(Parser<Character>.item()) { theChar in
        if predicate(theChar) {
            return Parser.result(value: theChar)
        } else {
            return Parser.zero()
        }
    }
}

let parser: Parser<Character> = satisfy { (char) -> Bool in
    char == "n"
}
