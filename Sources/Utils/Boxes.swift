// MARK: - Weak

public extension F {
    static func weak<A: AnyObject>(_ value: A) -> () -> A? {
        { [weak value] in value }
    }
    static func unowned<A: AnyObject>(_ value: A) -> () -> A {
        { [unowned value] in value }
    }
}

public struct Weak<T: AnyObject> {
    private let _internalValue: () -> T?
    
    public init(_ value: T) {
        _internalValue = F.weak(value)
    }
    
    public var value: T? {
        _internalValue()
    }
}

public struct Unowned<T: AnyObject> {
    private let _internalValue: () -> T
    
    public init(_ value: T) {
        _internalValue = F.unowned(value)
    }
    
    public var value: T {
        _internalValue()
    }
}

public final class Ref<T> {
    public var val: T
    public init(_ v: T) { val = v }
}

public struct CopyOnWriteBox<T> {
    private var ref: Ref<T>
    private let mutated: (T, T) -> Bool

    public init(_ x: T, mutated: @escaping (T, T) -> Bool) {
        ref = Ref(x)
        self.mutated = mutated
    }

    var value: T {
        get { ref.val }
        set {
            if !isKnownUniquelyReferenced(&ref), mutated(ref.val, newValue) {
                ref = Ref(newValue)
                return
            }
            ref.val = newValue
        }
    }
}

public extension CopyOnWriteBox where T: Equatable {
    init(_ x: T) { self.init(x, mutated: !=) }
}
