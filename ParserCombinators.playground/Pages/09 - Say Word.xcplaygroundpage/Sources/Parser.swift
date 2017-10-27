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

public func satisfy(predicate:@escaping ((Character) -> Bool)) -> Parser<Character> {
    return bind(Parser<Character>.item()) { theChar in
        if predicate(theChar) {
            return Parser.result(value: theChar)
        } else {
            return Parser.zero()
        }
    }
}

public func char(_ x:Character) -> Parser<Character> {
    return satisfy { $0 == x }
}

public func charIn<CharSeq: Sequence> (x:CharSeq) -> Parser<Character>
    where CharSeq.Iterator.Element == Character {
        return satisfy { Set(x).contains($0) }
}

public let digit:Parser<Character> = satisfy { "0"..."9" ~= $0 }
public let lower:Parser<Character> = satisfy { "a"..."z" ~= $0 }
public let upper:Parser<Character> = satisfy { "A"..."Z" ~= $0 }


public let nsParser:Parser<String> = bind(char("N")) { (theLetterN) in
    bind(char("S")) { (theLetterS) in
        Parser<String>.result(value: String([theLetterN, theLetterS]))
    }
}

public func headAndTail(_ input:String) -> (head:Character, tail:String)? {
    if let head = input.first {
        return (head, String(input.dropFirst()))
    } else {
        return nil
    }
}
