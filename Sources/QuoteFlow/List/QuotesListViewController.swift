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
    private var cancellables: Set<AnyCancellable> = .init()

    private let tableView = UITableView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = Consts.rowHeight
        $0.separatorStyle = .none
        $0.register(QuoteCell.self, forCellReuseIdentifier: QuoteCell.identifier)
    }
    private let dataSource: UITableViewDiffableDataSource<Int, QuoteCell.State>

    init(viewStore: QuoteFlowViewStore) {
        self.viewStore = viewStore
        dataSource = .init( tableView: tableView) { tbl, path, state in
            let cell: QuoteCell = tbl.dequeueReusableCell(withIdentifier: QuoteCell.identifier, for: path).apply(F.cast)!
            return cell.then { $0.configure(with: state) }
        }

        super.init(nibName: nil, bundle: nil)
        viewStore.action.load.perform()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupAutolayout()
        bindUpdate()
    }

    private func bindUpdate() {
        viewStore.store.stateDriver
//            .print("<<<QuoteList>>>")
            .sink(receiveValue: { [dataSource] state in
                let items = state.quotes.map { id, quote in
                    QuoteCell.State(quote: quote, isFavourite: state.favourites.contains(id))
                }
                let shot = F.updated(NSDiffableDataSourceSnapshot<Int, QuoteCell.State>()) {
                    $0.appendSections([0])
                    $0.appendItems(items)
                }
                dataSource.apply(shot, animatingDifferences: true)
            })
            .store(in: &cancellables)
    }

    private func setupAutolayout() {
        NSLayoutConstraint.activate(F.apply(tableView) {[
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            $0.topAnchor.constraint(equalTo: view.topAnchor),
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]})
    }
}

extension QuotesListViewController {
    enum Consts {
        static let rowHeight = QuoteCell.Consts.baseSize * 5
    }
}
