//
//  QuoteFlowTests.swift
//  
//
//  Created by Oleksii Hordiienko on 22.03.2023.
//

import XCTest
import Store
import Combine
@testable import QuoteFlow

@available(iOS 15, *)
final class QuoteFlowTests: XCTestCase {

    func testLoadPositive() async throws {
        let worker = QuoteFlowDataManager.mock
        let quotes = try await worker.getQuotes(.smi)

        let viewStore = QuoteFlowViewStore(
            worker: worker,
            store: Store(
                label: "QuotesListViewController.TestStore",
                state: QuoteFlowViewStore.State()
            )
        )
        viewStore.action.load.perform()

        for await _ in viewStore.store.stateDriver.prefix(2).values {}
        XCTAssertEqual(quotes.count, viewStore.store.state.quotes.count)
    }
}
