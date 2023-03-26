//
//  DependencyValues+Extension.swift
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

extension QuoteFlowDataManager: DependencyKey {
    public static var liveValue: QuoteFlowDataManager { .live }
    public static var previewValue: QuoteFlowDataManager { .mock }
}

extension DependencyValues {
    var env: Environment {
        get { self[Environment.self] }
        set { self[Environment.self] = newValue }
    }

    var worker: QuoteFlowDataManager {
        get { self[QuoteFlowDataManager.self] }
        set { self[QuoteFlowDataManager.self] = newValue }
    }
}

