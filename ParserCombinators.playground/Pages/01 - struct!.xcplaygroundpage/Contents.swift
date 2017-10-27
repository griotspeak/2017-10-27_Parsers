struct Parser<Value> {
    typealias Function = (String) -> (Value, remainder:String)?
    let apply:Function

    init(apply: @escaping Function) {
        self.apply = apply
    }
}
