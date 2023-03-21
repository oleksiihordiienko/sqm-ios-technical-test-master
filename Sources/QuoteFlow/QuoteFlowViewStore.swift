//
//  QuoteFlowViewStore.swift
//  
//
//  Created by Oleksii Hordiienko on 21.03.2023.
//

import Foundation
import Store

final class QuoteFlowViewStore {
    struct State {
    }

    private let worker: QuoteFlowDataManager
    private let store: Store<State>

    init(worker: QuoteFlowDataManager, store: Store<State>) {
        self.worker = worker
        self.store = store
    }
}
