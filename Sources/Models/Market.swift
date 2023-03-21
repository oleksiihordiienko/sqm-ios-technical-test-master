//
//  Market.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 30.04.21.
//

import Foundation
import Resources

public enum Market {
    case smi
}

public extension Market {
    var name: String {
        switch self {
        case .smi: return L10n.Market.smi
        }
    }
}
