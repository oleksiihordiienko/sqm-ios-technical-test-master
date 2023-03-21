//
//  File.swift
//  
//
//  Created by Oleksii Hordiienko on 21.03.2023.
//

import UIKit
import Store

public final class QouteFlowController: UINavigationController {
    private let root: QuotesListViewController

    public init(
        worker: QuoteFlowDataManager = .live,
        listState: QuoteFlowViewStore.State = .init()
    ) {
        root = Self.getList(with: listState, worker)
        super.init(rootViewController: root)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func getList(
        with state: QuoteFlowViewStore.State,
        _ worker: QuoteFlowDataManager
    ) -> QuotesListViewController {
        let store = Store(label: "QuotesListViewController.Store", state: state)
        let viewStore = QuoteFlowViewStore(worker: worker, store: store)
        return .init(viewStore: viewStore)
    }
}
