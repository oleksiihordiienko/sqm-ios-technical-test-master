//
//  File.swift
//  
//
//  Created by Oleksii Hordiienko on 21.03.2023.
//

import Foundation
import UIKit
import Models

public enum ServerModel {
}

public extension ServerModel {
    struct Quote: Decodable {
        let key: String
        let name: String
        let symbol: String
        let currency: String
        let last: String
        let readableLastChangePercent: String?
        let variationColor: String?
    }
}

extension Quote {
    public static func build(with market: Market) -> (ServerModel.Quote) -> Self {
        { .init(market: market, smdl: $0) }
    }

    init(
        market: Market,
        smdl: ServerModel.Quote
    ) {

        self.init(
            id: smdl.key,
            market: market,
            currency: .init(rawValue: smdl.currency),
            name: smdl.name,
            symbol: smdl.symbol,
            last: Double(smdl.last) ?? 0,
            readableLastChangePercent: smdl.readableLastChangePercent ?? "",
            variationColor: .build(rawValue: smdl.variationColor)
        )
    }
}

extension Currency {
    init(rawValue: String) {
        switch rawValue {
        case Currency.chf.rawValue: self = .chf
        default: self = .unknown(rawValue)
        }
    }
}

extension Quote.VariantColor {
    static func build(rawValue: String?) -> Self {
        switch rawValue {
        case "green": return .green
        case "red": return .red
        default: return Self.default
        }
    }
}
