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
}

public struct CommandWith<T> {
    private let action: (T) -> Void

    public init(_ action: @escaping (T) -> Void) {
        self.action = action
    }

    public func perform(with value: T) {
        action(value)
    }
}

public extension CommandWith {
    static var empty: Self {
        .init { _ in }
    }
}
