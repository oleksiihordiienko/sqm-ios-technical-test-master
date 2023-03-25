//
//  QuoteCellTableViewCell.swift
//  
//
//  Created by Oleksii Hordiienko on 21.03.2023.
//

import UIKit
import Environment
import Models
import Resources
import Utils

final class QuoteCell: UITableViewCell {
    public static let identifier = "QuoteCell"

    public var formatCurrency = Current.format.currency

    let backView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.borderColor = UIColor.blue.cgColor
    }

    private static func label(
        textAlignment: NSTextAlignment = .left,
        fontSize: CGFloat = Consts.baseSize
    ) -> UILabel {
        UILabel().then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.textAlignment = textAlignment
            $0.font = .systemFont(ofSize: fontSize)
        }
    }
    let nameLabel = QuoteCell.label()
    let lastLabel = QuoteCell.label()
    let currencyLabel = QuoteCell.label()
    let percentLabel = QuoteCell.label(
        textAlignment: .right,
        fontSize: Consts.Size.percent
    )

    private static func stack(axis: NSLayoutConstraint.Axis = .horizontal) -> UIStackView {
        UIStackView().then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.axis = axis
            $0.spacing = Consts.baseSize
        }
    }
    let currenyStack = QuoteCell.stack()
    let leadingStack = QuoteCell.stack(axis: .vertical)
    let trailingStack = QuoteCell.stack()

    let favouriteIcon = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.layer.then {
            $0.borderWidth = Consts.contentEdge
            $0.borderColor = UIColor.black.cgColor
        }
        addSubviews()
        setupAutolayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backView.layer.borderWidth = selected ? Consts.tinyEdge : 0
    }

    public struct State: Hashable, Equatable {
        let quote: Quote
        let isFavourite: Bool

        func hash(into hasher: inout Hasher) {
            hasher.combine(quote.id)
        }
    }

    public func configure(with state: State) {
        F.apply(state.quote) {
            nameLabel.text = $0.name
            lastLabel.text = formatCurrency($0.last)
            currencyLabel.text = $0.currency.rawValue
            F.apply((
                percentLabel,
                $0.readableLastChangePercent,
                $0.variationColor
            )) { label, text, color in
                label.text = text
                label.textColor = color.uiColor
            }
        }
        favouriteIcon.image = state.isFavourite
            ? Asset.QuoteFlow.favorite
            : Asset.QuoteFlow.noFavorite
    }

    private func addSubviews() {
        contentView.addSubview(backView)
        backView.h.addViews(
            leadingStack.h.addArrangedViews(
                nameLabel,
                currenyStack.h.addArrangedViews(
                    lastLabel,
                    currencyLabel
                )
            ),
            trailingStack.h.addArrangedViews(
                percentLabel,
                favouriteIcon
            )
        )
    }

    private func setupAutolayout() {
        NSLayoutConstraint.activate(F.apply((backView, contentView, Consts.contentEdge)) { me, sup, const in [
            me.leadingAnchor.constraint(equalTo: sup.leadingAnchor, constant: const),
            me.trailingAnchor.constraint(equalTo: sup.trailingAnchor, constant: -const),
            me.topAnchor.constraint(equalTo: sup.topAnchor, constant: const),
            me.bottomAnchor.constraint(equalTo: sup.bottomAnchor, constant: -const),
        ]})

        NSLayoutConstraint.activate(F.apply((leadingStack, backView, Consts.baseSize)) { me, sup, const in [
            me.leadingAnchor.constraint(equalTo: sup.leadingAnchor, constant: const),
            me.trailingAnchor.constraint(equalTo: sup.centerXAnchor),
            me.topAnchor.constraint(equalTo: sup.topAnchor, constant: const),
            me.bottomAnchor.constraint(equalTo: sup.bottomAnchor, constant: -const),
        ]})
        lastLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        NSLayoutConstraint.activate(F.apply((favouriteIcon, Consts.Size.favourite)) { me, const in [
            me.widthAnchor.constraint(equalToConstant: const),
            me.heightAnchor.constraint(equalToConstant: const)
        ]})

        NSLayoutConstraint.activate(F.apply((trailingStack, backView, Consts.baseSize)) { me, sup, const in [
            me.leadingAnchor.constraint(greaterThanOrEqualTo: sup.centerXAnchor, constant: const),
            me.trailingAnchor.constraint(equalTo: sup.trailingAnchor, constant: -const),
            me.centerYAnchor.constraint(equalTo: sup.centerYAnchor),
        ]})
    }
}

extension QuoteCell {
    enum Consts {
        static let contentEdge: CGFloat = 1
        static let tinyEdge: CGFloat = 2
        static let baseSize: CGFloat = 16

        enum Size {
            static let percent = Consts.baseSize + 8
            static let favourite = Consts.baseSize * 2.5
        }
    }
}
