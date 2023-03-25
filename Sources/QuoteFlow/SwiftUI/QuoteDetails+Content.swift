//
//  QuoteDetails+Content.swift
//  
//
//  Created by Oleksii Hordiienko on 23.03.2023.
//

import SwiftUI
import ComposableArchitecture
import Models
import QuoteFlowDataManager
import Resources
import Environment
import Utils

extension QuoteDetails {
    struct Content: View {
        @Dependency(\.env.format.currency) var formatCurrency

        let store: Store<State, Void>

        var body: some View {
            VStack(spacing: .zero) {
                WithViewStore(store, observe: F.id) { viewStore in
                    Text(viewStore.quote.symbol)
                        .font(.system(size: Consts.FontSize.symbolLabel, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.top, Consts.Top.symbolLabel)

                    Text(viewStore.quote.name)
                        .font(.system(size: Consts.FontSize.nameLabel))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .padding(.top, Consts.Top.nameLabel)

                    HStack {
                        Text(formatCurrency(viewStore.quote.last))
                            .font(.system(size: Consts.FontSize.lastLabel))

                        Text(viewStore.quote.currency.rawValue)
                            .font(.system(size: Consts.FontSize.currencyLabel))

                        readableLastChangePercent(with: viewStore)
                    }
                    .padding(.top, Consts.Top.lastStack)

                    favouriteButton(with: viewStore)
                        .padding(.top, Consts.Top.favoriteButton)
                }

                Spacer()
            }
        }

        func readableLastChangePercent(with viewStore: ViewStore<QuoteDetails.State, Void>) -> some View {
            Text(viewStore.quote.readableLastChangePercent)
                .font(.system(size: Consts.FontSize.readableLastChangePercentLabel))
                .foregroundColor(Color(uiColor: viewStore.quote.variationColor.uiColor))
                .frame(
                    width: Consts.Width.readableLastChangePercentLabel,
                    height: Consts.Height.readableLastChangePercentLabel
                )
                .overlay(RoundedRectangle(cornerRadius: Consts.cornerRadius).stroke(
                    Color(uiColor: viewStore.quote.variationColor.uiColor),
                    lineWidth: Consts.BorderWidth.readableLastChangePercentLabel
                ))
        }

        func favouriteButton(with viewStore: ViewStore<QuoteDetails.State, Void>) -> some View {
            Button(L10n.QuoteFlow.Details.favoriteTitle) {
                viewStore.send(())
            }
            .buttonStyle(.plain)
            .frame(
                width: Consts.Width.favoriteButton,
                height: Consts.Height.favoriteButton
            )
            .overlay(RoundedRectangle(cornerRadius: Consts.cornerRadius).stroke(
                viewStore.isFavourite ? .gray : .yellow,
                lineWidth: Consts.BorderWidth.favoriteButton
            ))
        }
    }
}

extension QuoteDetails.Content {
    enum Consts {
        static let cornerRadius: CGFloat = 6
    }
}

extension QuoteDetails.Content.Consts {
    enum FontSize {
        private static let base: CGFloat = 30

        static let symbolLabel = base + 10
        static let nameLabel = base
        static let lastLabel = base
        static let currencyLabel = base / 2
        static let readableLastChangePercentLabel = base
    }
    enum Top {
        private static let base: CGFloat = 10

        static let symbolLabel = base * 3
        static let nameLabel = base
        static let lastStack = base
        static let favoriteButton = base * 3
    }
    enum Width {
        private static let base: CGFloat = 150

        static let readableLastChangePercentLabel = base
        static let favoriteButton = base
    }
    enum BorderWidth {
        static let readableLastChangePercentLabel: CGFloat = 1
        static let favoriteButton: CGFloat = 3
    }
    enum Height {
        private static let base: CGFloat = 44

        static let readableLastChangePercentLabel = base
        static let favoriteButton = base
    }
}

struct Previews_QuoteDetails_Content_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            QuoteDetails.Content(store: Store(
                initialState: .init(quote: .preview1, isFavourite: false),
                reducer: EmptyReducer()
            ))
            QuoteDetails.Content(store: Store(
                initialState: .init(quote: .preview2, isFavourite: true),
                reducer: EmptyReducer()
            ))
        }
    }
}
