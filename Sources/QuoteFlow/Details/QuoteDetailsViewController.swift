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

public final class QuoteDetailsViewController: UIViewController {
    
    public var quote: Quote {
        didSet { didSetQuote(quote) }
    }

    public var formatCurrency = Current.format.currency
    public var defaultQuoteVariantColor = Current.defaultQuoteVariantColor

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
    let favoriteButton = UIButton().then {
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle(L10n.QuoteFlow.Details.favoriteTitle, for: .normal)
        $0.layer.then {
            $0.cornerRadius = Consts.cornerRadius
            $0.masksToBounds = true
            $0.borderWidth = Consts.BorderWidth.favoriteButton
            $0.borderColor = UIColor.black.cgColor
        }
    }

    var allViews: [UIView] {[
        symbolLabel,
        nameLabel,
        lastLabel,
        currencyLabel,
        readableLastChangePercentLabel,
        favoriteButton,
    ]}

    public init(quote: Quote = SampleData.preview1) {
        self.quote = quote
        super.init(nibName: nil, bundle: nil)
        didSetQuote(quote)
        favoriteButton.addTarget(self, action: #selector(didPressFavoriteButton), for: .touchUpInside)
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

    private func didSetQuote(_ quote: Quote) {
        guard quote != SampleData.empty else {
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
        F.apply(quote) {
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
        // TODO
    }
}

public extension QuoteDetailsViewController {
    enum SampleData {}
}

public extension QuoteDetailsViewController.SampleData {
    static var empty: Quote {
        .init(
            id: "",
            market: .smi,
            currency: .unknown(""),
            name: "",
            symbol: "",
            last: 0,
            readableLastChangePercent: "",
            variationColor: .default
        )
    }

    static var preview1: Quote {
        .init(
            id: "SMI_PR_Preview_1",
            market: .smi,
            currency: .chf,
            name: "SMI PR",
            symbol: "SMI PR Symbol",
            last: 11,
            readableLastChangePercent: "-0.26 %",
            variationColor: .red
        )
    }

    static var preview2: Quote {
        .init(
            id: "",
            market: .smi,
            currency: .chf,
            name: "SWISSCOM M",
            symbol: "SWISSCOM M Symbol",
            last: 494.20,
            readableLastChangePercent: "3.98 %",
            variationColor: .green
        )
    }
}
