extension Parser {
    static func item() -> Parser<Character> {
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

let parser = Parser<Int>.item()
parser.apply("hello")
