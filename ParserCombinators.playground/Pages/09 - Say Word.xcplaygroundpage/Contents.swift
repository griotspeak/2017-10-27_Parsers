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

let parser = word("CocoaConf Lives")
parser.apply("CocoaConf Lives")
parser.apply("Hello World!")
