public struct Parser<Value> {
    public typealias Function = (String) -> (Value, remainder:String)?
    public let apply:Function

    public init(apply: @escaping Function) {
        self.apply = apply
    }
}
