//
//  QuoteFlowViewStore.swift
//  
//
//  Created by Oleksii Hordiienko on 21.03.2023.
//

import Foundation
import Combine
import Models
import Store
import Utils

final class QuoteFlowViewStore {
    struct State {
        let market = Market.smi
        var quotes: [Quote] = []
    }
    struct Events {
        var load: Command
        var select: CommandWith<Quote>
    }

    private let worker: QuoteFlowDataManager
    private var cancellables: Ref<Set<AnyCancellable>> = .init([])

    let store: Store<State>
    var events: Events

    init(worker: QuoteFlowDataManager, store: Store<State>) {
        self.worker = worker
        self.store = store
        self.events = .init(
            load: Self.load(worker, store, cancellables),
            select: .empty
        )
    }
}

extension QuoteFlowViewStore {
    static func load(
        _ worker: QuoteFlowDataManager,
        _ store: Store<State>,
        _ cancellables: Ref<Set<AnyCancellable>>
    ) -> Command { .init {

        store.updateTask {
            try await worker.getQuotes($0.market)
        } mutation: { state, quotes in
            state.quotes = quotes
        }
        .sink(receiveValue: F.voids)
        .store(in: &cancellables.val)
    }}
}
