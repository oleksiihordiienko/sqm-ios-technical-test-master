import Environment
import Foundation

public struct DecodeWitness<T> {
    public var decode: (Data, URLResponse) -> Result<T, Error>

    public func decode(_ response: (Data, URLResponse)) -> Result<T, Error> {
        decode(response.0, response.1)
    }

    public func map<Z>(_ transform: @escaping (T) -> Z) -> DecodeWitness<Z> {
        .init { decode($0, $1).map(transform) }
    }

    public func flatMapResult<Z>(_ transform: @escaping (T) -> Result<Z, Error>) -> DecodeWitness<Z> {
        .init { decode($0, $1).flatMap(transform) }
    }

    public func zip<Z>(with other: DecodeWitness<Z>) -> DecodeWitness<(T, Z)> {
        .init { data, response in
            let first = decode(data, response)
            let second = other.decode(data, response)
            return first.flatMap { value in
                second.map { (value, $0) }
            }
        }
    }
}

extension DecodeWitness {
    enum DecodeError: Error {
        case castFailure
        case headerAbsense
        case wrongStatusCode(Int)
    }
}

public extension DecodeWitness where T == (Data, URLResponse) {
    static func `default`(statusCodes: ClosedRange<Int> = 200...299) -> Self {
        .init { data, response in
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(DecodeError.castFailure)
            }
            guard statusCodes.contains(httpResponse.statusCode) else {
                return .failure(DecodeError.wrongStatusCode(httpResponse.statusCode))
            }
            return .success((data, response))
        }
    }

    static let id = Self { data, response in .success((data, response)) }
}

public extension DecodeWitness where T == (Data, String) {
    static func header(_ header: Endpoint.Header) -> DecodeWitness {
        .init { data, response in
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(DecodeError.castFailure)
            }
            guard let headerValue = httpResponse.value(forHTTPHeaderField: header.rawValue) else {
                return .failure(DecodeError.headerAbsense)
            }
            return .success((data, headerValue))
        }
    }
}

public extension DecodeWitness where T == Data {
    func decode<Z: Decodable>(to type: Z.Type) -> DecodeWitness<Z> {
        flatMapResult { data in
            Result { try Current.json.decoder.decode(type, from: data) }
        }
    }
}

public extension DecodeWitness where T: Decodable {
    static var `default`: Self {
        DecodeWitness<(Data, URLResponse)>.default()
            .flatMapResult { data, _ in
                Result { try Current.json.decoder.decode(T.self, from: data) }
            }
    }
}
