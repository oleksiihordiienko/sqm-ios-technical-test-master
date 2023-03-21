//
//  Consts.swift
//  
//
//  Created by Oleksii Hordiienko on 20.03.2023.
//

import Foundation

extension QuoteDetailsViewController {
    enum Consts {
        static let cornerRadius: CGFloat = 6
    }
}

extension QuoteDetailsViewController.Consts {
    enum FontSize {
        private static let base: CGFloat = 30

        static let symbolLabel = base + 10
        static let nameLabel = base
        static let lastLabel = base
        static let currencyLabel = base / 2
        static let readableLastChangePercentLabel = base
    }
    enum BorderWidth {
        static let readableLastChangePercentLabel: CGFloat = 1
        static let favoriteButton: CGFloat = 3
    }
    enum Leading {
        private static let base: CGFloat = 10

        static let symbolLabel = base
        static let nameLabel = base
        static let lastLabel = base
        static let currencyLabel = base / 2
        static let readableLastChangePercentLabel = base / 2
    }
    enum Trailing {
        static let symbolLabel: CGFloat = -10
        static let nameLabel: CGFloat = -10
    }
    enum Width {
        private static let base: CGFloat = 150

        static let lastLabel = base
        static let currencyLabel = base / 3
        static let readableLastChangePercentLabel = base
        static let favoriteButton = base
    }
    enum Top {
        private static let base: CGFloat = 10

        static let symbolLabel = base * 3
        static let nameLabel = base
        static let lastLabel = base
        static let favoriteButton = base * 3
    }
    enum Height {
        private static let base: CGFloat = 44

        static let symbolLabel = base
        static let nameLabel = base
        static let lastLabel = base
        static let currencyLabel = base
        static let favoriteButton = base
    }
}
