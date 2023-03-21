//
//  Environment.swift
//  
//
//  Created by Oleksii Hordiienko on 21.03.2023.
//

import Foundation
import Models
import Utils

public var Current = Environment.live

public struct Environment {
    public var json: JSONUtils
    public var request: Request
    public var format: Formatter
    public var defaultQuoteVariantColor = Quote.VariantColor.default
}

extension Environment {
    static let live = Self.init(
        json: JSONUtils(
            decoder: JSONDecoder(),
            encoder: JSONEncoder()
        ),
        request: Request(),
        format: Formatter()
    )
}

public struct Request {
    public var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    public var timeoutInterval: TimeInterval = 60.0
}

public struct Formatter {
    public var currency = Utils.Formatter.currency(forAmount:)
}
