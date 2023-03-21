//
//  File.swift
//  
//
//  Created by Oleksii Hordiienko on 16.02.2023.
//

import Foundation

public final class APIClient {
    private let session: URLSession

    public init(configuration: URLSessionConfiguration = .default) {
        session = URLSession(configuration: configuration)
    }

    public func send<T>(_ end: EndpointDecode<T>) async throws -> T {
        let end = try await update(end)
        let request = try end.endpoint.request
        let response = try await session.data(for: request)
        return try await decode(response, with: end)
    }
}

private extension APIClient {
    func update<T>(_ end: EndpointDecode<T>) async throws -> EndpointDecode<T> {
        // at the point we can update enpoint using local state of APIClient
        // for example update with custom headers based on local state or whatever
        return end
    }

    func decode<T>(
        _ response: (Data, URLResponse),
        with ed: EndpointDecode<T>
    ) async throws -> T {
        // again, at this point we can retry request, for example
        // or mutate local state, or whatever
        try ed.decodeWitness.decode(response).get()
    }
}
