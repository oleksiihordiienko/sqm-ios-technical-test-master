//
//  Asset.swift
//  
//
//  Created by Oleksii Hordiienko on 20.03.2023.
//

import UIKit

public enum Asset {
    public enum QuoteFlow { }
}

public extension Asset.QuoteFlow {
    static let favorite = Asset.img("favorite")
    static let noFavorite = Asset.img("no-favorite")
}

private extension Asset {
    static func img(_ name: String) -> UIImage {
        guard let image = UIImage(named: name, in: .module, compatibleWith: nil) else {
            fatalError("Unable to load image asset named \(name).")
        }
        return image
    }
}
