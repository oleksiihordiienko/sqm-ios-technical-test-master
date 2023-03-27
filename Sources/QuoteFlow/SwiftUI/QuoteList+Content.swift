//
//  QuoteList+Content.swift
//  
//
//  Created by Oleksii Hordiienko on 23.03.2023.
//

import SwiftUI
import ComposableArchitecture
import Utils

extension QuoteList {
    struct Contnent: View {
        let store: StoreOf<QuoteList>

        var body: some View {
            WithViewStore.init(store, observe: F.id) { viewStore in
                List(
                    viewStore.items,
                    selection: viewStore.binding(get: \.isSelected, send: QuoteList.Action.select)
                ) { itemState in
                    QuoteList.Item(state: itemState)
                        .listRowInsets(.init())
                        .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
                .task { viewStore.send(.load) }
            }
        }
    }
}

struct QuoteList_Contnent_Previews: PreviewProvider {
    static var previews: some View {
        QuoteList.Contnent(store: Store(
            initialState: QuoteList.State(),
            reducer: QuoteList()
        ))
    }
}

