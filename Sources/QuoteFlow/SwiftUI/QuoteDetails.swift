//
//  QuoteDetails.swift
//  
//
//  Created by Oleksii Hordiienko on 23.03.2023.
//

import ComposableArchitecture
import Models

struct QuoteDetails {
    struct State: Equatable {
        let quote: Quote
        let isFavourite: Bool
    }
}
