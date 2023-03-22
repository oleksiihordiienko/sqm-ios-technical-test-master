import Foundation


// MARK: - Command

public struct Command {
    private let action: () -> Void
    
    public init(_ action: @escaping () -> Void) {
        self.action = action
    }
    
    public init(_ optionalAction: (() -> Void)?) {
        action = optionalAction ?? {}
    }
    
    public init<A>(from action: @escaping (A) -> Void, _ value: A) {
        self.action = { action(value) }
    }
    
    public func perform() {
        action()
    }
}

public extension Command {
    static let empty = Command {}

    static func weak<A: AnyObject>(_ object: A, _ handler: @escaping (A) -> Void) -> Command {
        let this = Weak(object)
        return Command { this.value.map(handler) }
    }
}

public struct CommandWith<T> {
    private let action: (T) -> Void

    public init(_ action: @escaping (T) -> Void) {
        self.action = action
    }

    public func perform(with value: T) {
        action(value)
    }

    public func with(_ value: T) -> Command {
        .init { perform(with: value) }
    }
}

public extension CommandWith {
    static var empty: Self {
        .init { _ in }
    }

    static func weak<A: AnyObject>(_ object: A, _ handler: @escaping (A, T) -> Void) -> Self {
        let this = Weak(object)
        return .init { value in
            guard let object = this.value else { return }
            handler(object, value)
        }
    }
}
