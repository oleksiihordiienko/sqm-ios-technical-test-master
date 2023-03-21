//
//  Environment.swift
//  
//
//  Created by Oleksii Hordiienko on 21.03.2023.
//

import Foundation

public var Current = Environment.live

public struct Environment {
    public var json: JSONCoder
    public var request: Request
}

extension Environment {
    static let live = Self.init(
        json: JSONCoder(),
        request: Request()
    )
}

public struct Request {
    public var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    public var timeoutInterval: TimeInterval = 60.0
}

public struct JSONCoder {
    public var decoder = JSONDecoder()
    public var encoder = JSONEncoder()
}
