//
//  Functional.swift
//  
//
//  Created by Oleksii Hordiienko on 20.03.2023.
//

import Foundation

public enum F {}

public extension F {
    static func id<A>(_ value: A) -> A {
        return value
    }

    static func id<A>(_ value: inout A) {
    }

    static func const<A, B>(_ value: A) -> (B) -> A {
        return { _ in value }
    }

    static func voids<B>(_ value: B) {
        return ()
    }

    static func voids<A, B>(_ valueA: A, _ value: B) {
        return ()
    }

    static func cast<A, B>(_ value: A) -> B? {
        return value as? B
    }

    static func apply<A, B>(_ value: A, _ fun: (A) throws -> B) rethrows -> B {
        return try fun(value)
    }

    static func fromInout<A>(_ fun: @escaping (inout A) -> Void) -> (A) -> A {
        return { value in
            var value = value
            fun(&value)
            return value
        }
    }

    static func their<Root, Value, NewValue>(
      _ getter: @escaping (Root) -> Value,
      _ combining: @escaping (Value, Value) -> NewValue
      )
      -> (Root, Root) -> NewValue {
        return { combining(getter($0), getter($1)) }
    }

    static func returns<A>(_ fun: @escaping () throws -> A) rethrows -> A {
      return try fun()
    }
}
