//
//  File.swift
//  
//
//  Created by Oleksii Hordiienko on 21.03.2023.
//

import UIKit

public struct Quote: Identifiable, Equatable {
    public let id: String
    public let market: Market
    public let currency: Currency
    public let name: String
    public let symbol: String
    public let last: Double
    public let readableLastChangePercent: String
    public let variationColor: VariantColor

    public init(
        id: String,
        market: Market,
        currency: Currency,
        name: String,
        symbol: String,
        last: Double,
        readableLastChangePercent: String,
        variationColor: VariantColor
    ) {
        self.id = id
        self.market = market
        self.name = name
        self.symbol = symbol
        self.currency = currency
        self.last = last
        self.readableLastChangePercent = readableLastChangePercent
        self.variationColor = variationColor
    }
}

public extension Quote {
    enum VariantColor: Equatable {
        case green
        case `default`
    }
}

public extension Quote.VariantColor {
    var uiColor: UIColor {
        switch self {
        case .green: return .green
        default: return .black
        }
    }
}
