//
//  h+UIStackView.swift
//  
//
//  Created by Oleksii Hordiienko on 21.03.2023.
//

import UIKit

extension UIStackView: HelpersProvider {}

public extension HelpersExtension where Base == UIStackView {
    @discardableResult
    func addArrangedViews(_ views: [UIView]) -> Base {
        views.forEach { base.addArrangedSubview($0) }
        return base
    }
}

