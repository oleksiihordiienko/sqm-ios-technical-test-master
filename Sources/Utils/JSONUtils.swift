//
//  JSONUtils.swift
//  
//
//  Created by Oleksii Hordiienko on 21.03.2023.
//

import Foundation

public struct JSONUtils {
    public let decoder: JSONDecoder
    public let encoder: JSONEncoder

    public init(decoder: JSONDecoder, encoder: JSONEncoder) {
        self.decoder = decoder
        self.encoder = encoder
    }

    public func load<T: Decodable>(type: T.Type = T.self, filename fileName: String, bundle: Bundle) throws -> T {
        guard let jsonURL = bundle.url(forResource: fileName, withExtension: "json") else {
            throw Error.wrongJsonURL
        }
        let jsonData = try Data(contentsOf: jsonURL)
        return try decoder.decode(type, from: jsonData)
    }

    public func load<T: Decodable>(type: T.Type = T.self, jsonString: String) throws -> T {
        guard let jsonData = jsonString.data(using: .utf8) else {
            throw Error.stringToDataConversionFailure
        }
        return try decoder.decode(type, from: jsonData)
    }

    public func serialize<T: Encodable>(_ value: T) throws -> String {
        let jsonData = try encoder.encode(value)
        guard let text = String(data: jsonData, encoding: .utf8) else {
            throw Error.dataToStrinConversionFailure
        }
        return text
    }
}

extension JSONUtils {
    enum Error: Swift.Error {
        case wrongJsonURL
        case stringToDataConversionFailure
        case dataToStrinConversionFailure
    }
}
