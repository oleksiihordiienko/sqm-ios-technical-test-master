//
//  QuoteList.swift
//  
//
//  Created by Oleksii Hordiienko on 23.03.2023.
//

import Models
import ComposableArchitecture
import Utils

struct QuoteList: ReducerProtocol {
    struct State: Equatable {
        let market: Market = .smi
        var quotes: IdentifiedArrayOf<Quote> = []
        var favourites: Set<Quote.ID> = .init()
        var isSelected: Quote.ID?
    }
    enum Action: Equatable {
        case load
        case loadResponse(TaskResult<[Quote]>)
        case select(Quote)
    }

    @Dependency(\.worker) var worker

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .load:
            return .task { [market = state.market] in
                await .loadResponse(TaskResult { try await worker.getQuotes(market) })
            }

        case let .loadResponse(.success(quotes)):
            state.quotes = F.updated(.init()) {
                $0.append(contentsOf: quotes)
            }
            return .none

        case .loadResponse(.failure):
            state.isSelected = nil
            state.favourites = .init()
            return .none

        case let .select(quote):
            state.isSelected = quote.id
            return .none
        }
    }
}

extension QuoteList.State {
    var items: [QuoteList.ItemState] {
        quotes.map { QuoteList.ItemState(
            isSelected: isSelected == $0.id,
            isFavourite: favourites.contains($0.id),
            quote: $0
        )}
    }
}

