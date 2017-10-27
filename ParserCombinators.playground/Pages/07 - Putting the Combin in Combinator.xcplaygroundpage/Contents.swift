
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
nsParser.apply("NW")

