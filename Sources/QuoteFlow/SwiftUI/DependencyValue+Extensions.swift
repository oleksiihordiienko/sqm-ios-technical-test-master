//
//  File.swift
//  
//
//  Created by Oleksii Hordiienko on 23.03.2023.
//

import ComposableArchitecture
import QuoteFlowDataManager
import Environment

extension Environment: DependencyKey {
    public static var liveValue: Self { Current }
}

extension DependencyValues {
    var env: Environment {
        get { self[Environment.self] }
        set { self[Environment.self] = newValue }
    }
}


extension QuoteFlowDataManager: DependencyKey {
    public static var liveValue: QuoteFlowDataManager { .live }
    public static var previewValue: QuoteFlowDataManager { .mock }
}

