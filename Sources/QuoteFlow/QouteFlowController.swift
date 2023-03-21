//
//  File.swift
//  
//
//  Created by Oleksii Hordiienko on 21.03.2023.
//

import UIKit

public final class QouteFlowController: UINavigationController {
    private let root: QuotesListViewController

    init(worker: QuoteFlowDataManager = .mock) {
        root = QuotesListViewController()
        super.init(rootViewController: root)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
