//
//  File.swift
//  
//
//  Created by Oleksii Hordiienko on 23.03.2023.
//

import Models
import Resources
import QuoteFlowDataManager
import Utils
import ComposableArchitecture
import SwiftUI

extension QuoteList {
    struct ItemState: Identifiable, Equatable {
        let isSelected: Bool
        let isFavourite: Bool
        let quote: Quote

        var id: Quote.ID {
            quote.id
        }
    }

    struct Item: View {
        @Dependency(\.env.format.currency) var formatCurrency

        let state: ItemState

        var body: some View {
            HStack(spacing: Consts.Size.base) {
                VStack(alignment: .leading, spacing: Consts.Size.base) {
                    Text(state.quote.name)
                    HStack(spacing: Consts.Size.base) {
                        Text(formatCurrency(state.quote.last))
                        Text(state.quote.currency.rawValue)
                    }
                }

                Spacer()

                Text(state.quote.readableLastChangePercent)
                    .foregroundColor(Color(uiColor: state.quote.variationColor.uiColor))
                    .font(.system(size: Consts.Size.percent))

                Image(
                    uiImage: state.isFavourite ? Asset.QuoteFlow.favorite : Asset.QuoteFlow.noFavorite
                )
                .resizable()
                .h.frame(size: Consts.Size.favourite)
            }
            .font(.system(size: Consts.Size.base))
            .padding(Consts.Size.base)
            .border(.blue, width: state.isSelected ? Consts.tinyEdge : 0)
            .border(.black, width: Consts.contentEdge)
        }
    }
}

extension QuoteList.Item {
    enum Consts {
            static let contentEdge: CGFloat = 1
            static let tinyEdge: CGFloat = 2

            enum Size {
                static let base: CGFloat = 16
                static let percent = base + 8
                static let favourite = base * 2.5
            }
        }
}

struct QuoteList_Item_Previews: PreviewProvider {
    static var previews: some View {
        QuoteList.Item(state: .init(
            isSelected: true,
            isFavourite: true,
            quote: .preview2
        ))
    }
}
