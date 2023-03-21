//
//  QuotesListViewController.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import UIKit
import Models
import Combine
import Utils

public class QuotesListViewController: UIViewController {
    private let viewStore: QuoteFlowViewStore
    private var cancellabes: Set<AnyCancellable> = .init()

    init(viewStore: QuoteFlowViewStore) {
        self.viewStore = viewStore
        super.init(nibName: nil, bundle: nil)
        viewStore.action.load.perform()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        bindUpdate()
    }

    private func bindUpdate() {
        viewStore.store.stateDriver
            .print("<<<QuoteList>>>")
            .sink(receiveValue: F.voids)
            .store(in: &cancellabes)
    }
}
