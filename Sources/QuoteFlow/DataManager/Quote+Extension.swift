//
//  Quote+Extension.swift
//  
//
//  Created by Oleksii Hordiienko on 23.03.2023.
//

import Models

public extension Quote {
    static var empty: Quote {
        .init(
            id: "",
            market: .smi,
            currency: .unknown(""),
            name: "",
            symbol: "",
            last: 0,
            readableLastChangePercent: "",
            variationColor: .default
        )
    }

    static var preview1: Quote {
        .init(
            id: "SMI_PR_Preview_1",
            market: .smi,
            currency: .chf,
            name: "SMI PR",
            symbol: "SMI PR Symbol",
            last: 11,
            readableLastChangePercent: "-0.26 %",
            variationColor: .red
        )
    }

    static var preview2: Quote {
        .init(
            id: "",
            market: .smi,
            currency: .chf,
            name: "SWISSCOM M",
            symbol: "SWISSCOM M Symbol",
            last: 494.20,
            readableLastChangePercent: "3.98 %",
            variationColor: .green
        )
    }
}
