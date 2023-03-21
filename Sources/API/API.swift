//
//  API.swift
//  
//
//  Created by Oleksii Hordiienko on 21.03.2023.
//

import Foundation
import Models
import APIClient
import Utils

public enum API {
    public enum Quotes {
        static func url(market: Market) -> URL? {
            URL(
                string:  "https://www.swissquote.ch/mobile/iphone/Quote.action?formattedList&formatNumbers=true&listType=\(market.name)&addServices=true&updateCounter=true&&s=smi&s=$smi&lastTime=0&&api=2&framework=6.1.1&format=json&locale=en&mobile=iphone&language=en&version=80200.0&formatNumbers=true&mid=5862297638228606086&wl=sq"
            )
        }
    }
}

extension API.Quotes {
    static func getList(market: Market) throws -> EndpointDecode<[Quote]> {
        try .init(
            Endpoint(url: Self.url(market: market), method: .get),
            DecodeWitness<[ServerModel.Quote]>
                .default
                .map(F.map(Quote.build(with: market)))
        )
    }
}
