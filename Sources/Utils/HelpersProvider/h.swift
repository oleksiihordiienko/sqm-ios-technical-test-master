//
//  h.swift
//  
//
//  Created by Oleksii Hordiienko on 21.03.2023.
//

import UIKit

public protocol HelpersProvider {}

public extension HelpersProvider {
    var h: HelpersExtension<Self> {
        HelpersExtension(self)
    }
    static var h: HelpersExtension<Self>.Type {
        HelpersExtension<Self>.self
    }
}

public struct HelpersExtension<Base> {
    public let base: Base

    public static var base: Base.Type {
        return Base.self
    }

    fileprivate init(_ base: Base) {
        self.base = base
    }
}

extension NSObject: HelpersProvider {}
