//
//  QuoteFlowDataManager.swift
//  
//
//  Created by Oleksii Hordiienko on 21.03.2023.
//

import Environment
import Foundation
import API
import Models
import Utils

public struct QuoteFlowDataManager {
    public var getQuotes: @Sendable (Market) async throws -> [Quote]
}

public extension QuoteFlowDataManager {
    static let live: Self = F.apply(APIClient()) { client in
        .init(getQuotes: { market in
            let end = try API.Quotes.getList(market: market)
            return try await client.send(end)
        })
    }
    static let mock = Self(getQuotes: { market in
        let quotes = try Current.json.load(type: [ServerModel.Quote].self, filename: "quotes-stub", bundle: .module)
        return quotes.map(Quote.build(with: market))
    })
    static let error = Self(getQuotes: { _ in
        struct SmthBadHappened: Error {}
        throw SmthBadHappened()
    })
}
