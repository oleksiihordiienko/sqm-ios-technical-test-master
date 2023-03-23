//
//  QuoteDetailsViewController.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import UIKit
import Environment
import Models
import Utils
import Resources
import QuoteFlowDataManager

public final class QuoteDetailsViewController: UIViewController {

    var addToFavourite: CommandWith<QuoteCell.State> = .empty

    var formatCurrency = Current.format.currency
    var defaultQuoteVariantColor = Current.defaultQuoteVariantColor

    private var state: QuoteCell.State

    let symbolLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: Consts.FontSize.symbolLabel)
    }
    let nameLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: Consts.FontSize.nameLabel)
        $0.textColor = .lightGray
    }
    let lastLabel = UILabel().then {
        $0.textAlignment = .right
        $0.font = .systemFont(ofSize: Consts.FontSize.lastLabel)
    }
    let currencyLabel = UILabel().then {
        $0.font = .systemFont(ofSize: Consts.FontSize.currencyLabel)
    }
    let readableLastChangePercentLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: Consts.FontSize.readableLastChangePercentLabel)
        $0.layer.then {
            $0.cornerRadius = Consts.cornerRadius
            $0.masksToBounds = true
            $0.borderWidth = Consts.BorderWidth.readableLastChangePercentLabel
        }
    }
    let favouriteButton = UIButton().then {
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle(L10n.QuoteFlow.Details.favoriteTitle, for: .normal)
        $0.layer.then {
            $0.cornerRadius = Consts.cornerRadius
            $0.masksToBounds = true
            $0.borderWidth = Consts.BorderWidth.favoriteButton
        }
    }

    var allViews: [UIView] {[
        symbolLabel,
        nameLabel,
        lastLabel,
        currencyLabel,
        readableLastChangePercentLabel,
        favouriteButton,
    ]}

    init(state: QuoteCell.State) {
        self.state = state
        super.init(nibName: nil, bundle: nil)
        didSetQuote(state)
        favouriteButton.addTarget(self, action: #selector(didPressFavoriteButton), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        allViews.forEach(view.addSubview)
        setupAutolayout()
    }

    private func didSetQuote(_ state: QuoteCell.State) {
        guard state.quote != .empty else {
            symbolLabel.text = nil
            nameLabel.text = nil
            lastLabel.text = nil
            currencyLabel.text = nil
            readableLastChangePercentLabel.then {
                $0.textColor = defaultQuoteVariantColor.uiColor
                $0.layer.borderColor = defaultQuoteVariantColor.uiColor.cgColor
                $0.text = nil
            }
            readableLastChangePercentLabel.text = nil
            return
        }
        F.apply(state.quote) {
            symbolLabel.text = $0.symbol
            nameLabel.text = $0.name
            lastLabel.text = formatCurrency($0.last)
            currencyLabel.text = $0.currency.rawValue
            F.apply((
                readableLastChangePercentLabel,
                $0.readableLastChangePercent,
                $0.variationColor
            )) { label, text, color in
                label.textColor = color.uiColor
                label.layer.borderColor = color.uiColor.cgColor
                label.text = text
            }
        }
        favouriteButton.then {
            $0.isEnabled = !state.isFavourite
            let color = state.isFavourite ? UIColor.black : .yellow
            $0.layer.borderColor = color.cgColor
        }
    }
    
    private func setupAutolayout() {
        allViews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate(
            view.safeAreaLayoutGuide
                .apply { horizontalConstraints($0) + verticalConstraints($0) }
                .flatMap(F.id)
        )
    }

    @objc func didPressFavoriteButton(_ sender:UIButton!) {
        addToFavourite.perform(with: state)
    }
}
