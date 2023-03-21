//
//  File.swift
//  
//
//  Created by Oleksii Hordiienko on 16.02.2023.
//

import Foundation

public struct EndpointDecode<T> {
    public let endpoint: Endpoint
    public let decodeWitness: DecodeWitness<T>

    public init(_ endpoint: Endpoint, _ decodeWitness: DecodeWitness<T>) {
        self.endpoint = endpoint
        self.decodeWitness = decodeWitness
    }
}
