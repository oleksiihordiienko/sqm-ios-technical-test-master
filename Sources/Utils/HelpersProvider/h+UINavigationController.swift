//
//  File.swift
//  
//
//  Created by Oleksii Hordiienko on 22.03.2023.
//

import UIKit

public extension HelpersExtension where Base == UINavigationController {
    func popViewController(animated: Bool, completion: Command) {
        base.popViewController(animated: animated)
        guard animated, let coordinator = base.transitionCoordinator else {
            DispatchQueue.main.async(execute: completion.perform)
            return
        }

        coordinator.animate(alongsideTransition: nil) { _ in
            DispatchQueue.main.async(execute: completion.perform)
        }
    }
}
