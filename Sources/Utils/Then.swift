//
//  Then.swift
//  
//
//  Created by Oleksii Hordiienko on 20.03.2023.
//

import Foundation

public protocol Then {}

public extension Then where Self: AnyObject {
  @inlinable @discardableResult
  func then(_ block: (Self) throws -> Void) rethrows -> Self {
    try block(self)
    return self
  }

  func apply<T>(_ block: (Self) throws -> T) rethrows -> T {
    try block(self)
  }
}

extension NSObject: Then {}
