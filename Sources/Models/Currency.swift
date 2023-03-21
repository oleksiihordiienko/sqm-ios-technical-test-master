//
//  Quote.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import Foundation
import Resources

public enum Currency {
    case chf
    case unknown(String)
}

extension Currency: Equatable {
    public var rawValue: String {
        switch self {
        case .chf: return L10n.Currency.chf
        case let .unknown(value): return value
        }
    }
}
