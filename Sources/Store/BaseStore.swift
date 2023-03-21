//
//  BaseStore.swift
//  
//
//  Created by Oleksii Hordiienko on 21.03.2023.
//

import Foundation
import Combine
import Utils

public class BaseStore<State> {
    private var _stateSubject: CurrentValueSubject<State, Never>

    private var _state: State {
        didSet { _stateSubject.send(_state) }
    }

    public var stateDriver: AnyPublisher<State, Never> {
        _stateSubject
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    public var state: State { _state }

    public let label: String

    public init(label: String, state: State) {
        self.label = label
        _stateSubject = CurrentValueSubject(state)
        self._state = state
    }

    public func update(_ mutation: @escaping (inout State) -> Void) {
        let update = F.fromInout(mutation)
        self._state = update(_state)
    }
}

