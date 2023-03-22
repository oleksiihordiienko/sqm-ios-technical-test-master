//
//  File.swift
//  
//
//  Created by Oleksii Hordiienko on 22.03.2023.
//

import UIKit

public extension HelpersExtension where Base == UIView {
    @discardableResult
    func addViews(_ views: UIView...) -> Base {
        views.forEach(base.addSubview)
        return base
    }
}
