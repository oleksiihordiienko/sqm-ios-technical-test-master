//
//  h+Optional.swift
//  
//
//  Created by Oleksii Hordiienko on 21.03.2023.
//

import Foundation

public protocol OptionalType {
  associatedtype Wrapped
  var value: Wrapped? { get }
}

extension Optional: OptionalType {
  public var value: Wrapped? {
    return self
  }
}

extension Optional: Error where Wrapped: Error {}

extension Optional: HelpersProvider {}

public extension HelpersExtension where Base: OptionalType {
    var isSome: Bool { base.value != nil }
    var isNone: Bool { base.value == nil }

    func foldMap<A>(ifNone: @autoclosure () -> A, ifSome: (Base.Wrapped) -> A) -> A {
        base.value.map(ifSome) ?? ifNone()
    }

    func `do`(_ sideEffect: (Base.Wrapped) -> Void) {
        base.value.map(sideEffect)
    }
}
