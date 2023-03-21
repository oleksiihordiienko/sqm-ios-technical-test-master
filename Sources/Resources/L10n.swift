//
//  L10n.swift
//  
//
//  Created by Oleksii Hordiienko on 20.03.2023.
//

import Foundation

public enum L10n {
    public enum QuoteFlow {}
    public enum Currency {}
    public enum Market {}
}

public extension L10n.QuoteFlow {
    enum Details {
        public static let favoriteTitle = L10n.tr("QuoteFlow.Details.FavoriteTitle")
    }
}

public extension L10n.Currency {
    static let chf = L10n.tr("Currency.CHF")
}

public extension L10n.Market {
    static let smi = L10n.tr("Market.SMI")
}

private extension L10n {
    static func tr(_ key: String, _ args: CVarArg...) -> String {
        let format = Bundle.module.localizedString(forKey: key, value: nil, table: "Localizable")
        return String(format: format, locale: Locale.current, args)
    }
}
