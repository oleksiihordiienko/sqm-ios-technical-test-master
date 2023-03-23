//
//  QuoteFlowViewStore.swift
//  
//
//  Created by Oleksii Hordiienko on 21.03.2023.
//

import Foundation
import Combine
import OrderedCollections
import Models
import Store
import Utils
import QuoteFlowDataManager

public final class QuoteFlowViewStore {
    public struct State {
        let market = Market.smi
        var quotes: OrderedDictionary<Quote.ID, Quote> = [:]
        var favourites: Set<Quote.ID> = .init()

        public init() {}
    }
    struct Action {
        var load: Command
        var setFavourite: CommandWith<QuoteCell.State>
    }

    private let worker: QuoteFlowDataManager
    private var cancellables: Ref<Set<AnyCancellable>> = .init([])

    let store: Store<State>
    var action: Action

    init(worker: QuoteFlowDataManager, store: Store<State>) {
        self.worker = worker
        self.store = store
        self.action = .init(
            load: Self.load(worker, store, cancellables),
            setFavourite: Self.setFavourite(store)
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
            state.quotes = .init(
                quotes.map { (key: $0.id, value: $0) },
                uniquingKeysWith: { first, _ in first }
            )
            state.favourites = state.favourites.filter { id in
                state.quotes[id].h.isSome
            }
        } catch: { _, error in
            //TODO: make Services module and put Logger into it
            print(#file, #line, error)
        }
        .sink(receiveValue: F.voids)
        .store(in: &cancellables.val)
    }}

    static func setFavourite(
        _ store: Store<State>
    ) -> CommandWith<QuoteCell.State> { .init { quoteState in
        store.update { state in
            state.favourites.insert(quoteState.quote.id)
        }
    }}
}
