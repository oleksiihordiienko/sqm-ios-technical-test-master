//
//  File.swift
//  
//
//  Created by Oleksii Hordiienko on 23.03.2023.
//

import ComposableArchitecture
import Environment

extension Environment: DependencyKey {
    public static var liveValue: Self { Current }
}

extension DependencyValues {
    var currentEnv: Environment {
        get { self[Environment.self] }
        set { self[Environment.self] = newValue }
    }
}
