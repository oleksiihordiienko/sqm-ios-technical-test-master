//
//  Store.swift
//  
//
//  Created by Oleksii Hordiienko on 21.03.2023.
//

import Foundation
import Combine

public final class Store<State>: BaseStore<State> {
    private let _mutationQueue: DispatchQueue

    override public var state: State {
        _mutationQueue.sync { super.state }
    }

    override public init(label: String, state: State) {
        _mutationQueue = DispatchQueue(label: "\(label).Mut", qos: .utility)
        super.init(label: label, state: state)
    }

    override public func update(_ mutation: @escaping (inout State) -> Void) {
        _mutationQueue.async { super.update(mutation) }
    }

    public func updateTask<T, Z>(
        priority: TaskPriority? = nil,
        operation: @escaping @Sendable (State) async throws -> T,
        mutation: @escaping (inout State, T) -> Void,
        catch handler: (@Sendable (State, Error) async -> Z)? = nil,
        catchMutation mutationHandler: @escaping (inout State, Z) -> Void = { _, _ in }
    ) -> AnyPublisher<Void, Never> {
        Deferred {
            let subject = PassthroughSubject<Void, Never>()
            let task = Task(priority: priority) {
                do {
                    try Task.checkCancellation()
                    let value = try await operation(self.state)
                    try Task.checkCancellation()
                    self.update { state in
                        mutation(&state, value)
                        subject.send(())
                        subject.send(completion: .finished)
                    }
                } catch is CancellationError {
                    subject.send(completion: .finished)
                } catch {
                    guard let errValue = await handler?(self.state, error) else {
                        return subject.send(completion: .finished)
                    }
                    self.update { state in
                        mutationHandler(&state, errValue)
                        subject.send(())
                        subject.send(completion: .finished)
                    }
                }
            }
            return subject.handleEvents(receiveCancel: task.cancel)
        }.eraseToAnyPublisher()
    }
}
