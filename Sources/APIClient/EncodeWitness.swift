import Foundation
import Environment

public struct EncodeWitness<T> {
    public let model: T
    public let encode: (T) throws -> Data

    public init(
        model: T,
        encode: @escaping (T) throws -> Data
    ) {
        self.model = model
        self.encode = encode
    }

    public var encodedData: Data {
        get throws { try encode(model) }
    }

    public func apply(to request: inout URLRequest) throws {
        request.httpBody = try encodedData
    }
}

public extension EncodeWitness where T: Encodable {
    init(model: T) {
        self.model = model
        self.encode = { try Current.json.encoder.encode($0) }
    }
}
