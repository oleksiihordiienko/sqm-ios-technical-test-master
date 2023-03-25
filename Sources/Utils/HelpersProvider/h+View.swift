//
//  h+View.swift
//  
//
//  Created by Oleksii Hordiienko on 25.03.2023.
//

import SwiftUI

public extension View {
    var h: HelpersExtension<Self> {
        HelpersExtension(self)
    }
    static var h: HelpersExtension<Self>.Type {
        HelpersExtension<Self>.self
    }
}

public extension HelpersExtension where Base: View {
    func frame(size: CGFloat, alignment: Alignment = .center) -> some View {
        base.frame(width: size, height: size, alignment: .center)
    }
}
