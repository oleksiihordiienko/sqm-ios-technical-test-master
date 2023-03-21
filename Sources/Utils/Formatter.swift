//
//  File.swift
//  
//
//  Created by Oleksii Hordiienko on 21.03.2023.
//

import Foundation

public enum Formatter {
    public static func currency(forAmount amount: Double) -> String {
        NumberFormatter()
            .then {
                $0.numberStyle = .decimal
                $0.groupingSeparator = ", "
                $0.minimumFractionDigits = 2
                $0.maximumFractionDigits = 2
            }
            .apply { $0.string(for: amount) ?? "" }
    }
}
