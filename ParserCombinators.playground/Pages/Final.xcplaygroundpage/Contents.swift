struct Parser<Value> {
    typealias Function = (String) -> (Value, remainder:String)?
    let apply:Function

    init(apply: @escaping Function) {
        self.apply = apply
    }
}

extension Parser {
    static func result(value:Value) -> Parser {
        return Parser { (input) in
            return (value, remainder:input)
        }
    }
}

let foo = Parser<Int>.result(value: 3)
foo.apply("hello")

extension Parser {
    static func zero() -> Parser {
        return Parser { (input) in
            return nil
        }
    }
}

let bar = Parser<Int>.zero()
bar.apply("hello")


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


func bind<T, U>(_ parserT:Parser<T>, lift:@escaping ((T) -> Parser<U>)) -> Parser<U> {
    return Parser<U> { (input) in
        if let (theT, theRemainder) = parserT.apply(input) {
            return lift(theT).apply(theRemainder)
        } else {
            return nil
        }
    }
}

let baz = Parser<Int>.item()
baz.apply("hello")


func satisfy(predicate:@escaping ((Character) -> Bool)) -> Parser<Character> {
    return bind(Parser<Character>.item()) { theChar in
        if predicate(theChar) {
            return Parser.result(value: theChar)
        } else {
            return Parser.zero()
        }
    }
}

func char(_ x:Character) -> Parser<Character> {
    return satisfy { $0 == x }
}

func charIn<CharSeq: Sequence> (x:CharSeq) -> Parser<Character>
    where CharSeq.Iterator.Element == Character {
        return satisfy { Set(x).contains($0) }
}

let digit:Parser<Character> = satisfy { "0"..."9" ~= $0 }
let lower:Parser<Character> = satisfy { "a"..."z" ~= $0 }
let upper:Parser<Character> = satisfy { "A"..."Z" ~= $0 }


let nsParser:Parser<String> = bind(char("N")) { (theLetterN) in
    bind(char("S")) { (theLetterS) in
        Parser<String>.result(value: String([theLetterN, theLetterS]))
    }
}

nsParser.apply("NS")
nsParser.apply("NE")

extension Optional {
    internal func bind<U>(f: (Wrapped) -> U?) -> U? {
        if let x = self {
            return f(x)
        } else {
            return nil
        }
    }
}

func headAndTail(_ input:String) -> (head:Character, tail:String)? {
    let characters = input.characters
    return characters.first.bind { head in
        let headIndex = input.startIndex
        let tailIndex = characters.index(after: headIndex)

        return (head:head, tail: String(input[tailIndex..<input.endIndex]))
    }
}

func word(_ x:String) -> Parser<String> {
    if let found = headAndTail(x) {
        return bind(char(found.head)) { (a:Character) in
            return bind(word(found.tail)) { (b:String) in
                return Parser<String>.result(value: x)
            }
        }
    } else {
        return Parser<String>.result(value: x)
    }
}

word("Happy").apply("Happy")


func choice<T>(_ lhs:Parser<T>, _ rhs:Parser<T>) -> Parser<T> {
    return Parser { (input) in
        if let leftParse = lhs.apply(input) {
            return leftParse
        } else {
            return rhs.apply(input)
        }
    }
}


