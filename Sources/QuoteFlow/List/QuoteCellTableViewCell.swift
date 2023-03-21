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

final class QuoteCellTableViewCell: UITableViewCell {
    public static let identifier = "QuoteCellTableViewCell"

    public var formatCurrency = Current.format.currency

    let backView = UIView().then {
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
    let nameLabel = QuoteCellTableViewCell.label()
    let lastLabel = QuoteCellTableViewCell.label()
    let currencyLabel = QuoteCellTableViewCell.label()
    let percentLabel = QuoteCellTableViewCell.label(
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
    let currenyStack = QuoteCellTableViewCell.stack()
    let leadingStack = QuoteCellTableViewCell.stack(axis: .vertical)
    let trailingStack = QuoteCellTableViewCell.stack()

    let favouriteView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        contentView.layer.then {
            $0.borderWidth = Consts.tinyEdge
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

    public func configure(with quote: Quote, isFavourite: Bool) {
        F.apply(quote) {
            nameLabel.text = $0.name
            lastLabel.text = formatCurrency($0.last)
            currencyLabel.text = $0.currency.rawValue
            F.apply((
                percentLabel,
                $0.readableLastChangePercent,
                $0.variationColor
            )) { label, text, color in
                label.textColor = color.uiColor
                label.layer.borderColor = color.uiColor.cgColor
                label.text = text
            }
        }
        favouriteView.image = isFavourite
            ? Asset.QuoteFlow.favorite
            : Asset.QuoteFlow.noFavorite
    }

    private func addSubviews() {
        [
            backView,
            leadingStack.h.addArrangedViews([
                nameLabel,
                currenyStack.h.addArrangedViews([
                    lastLabel,
                    currencyLabel
                ])
            ]),
            trailingStack.h.addArrangedViews([
                percentLabel,
                favouriteView
            ])
        ].forEach(contentView.addSubview)
    }

    private func setupAutolayout() {
        NSLayoutConstraint.activate(F.apply(backView) {[
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Consts.tinyEdge),
            $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Consts.tinyEdge),
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Consts.tinyEdge),
            $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Consts.tinyEdge),
        ]})

        NSLayoutConstraint.activate(F.apply(favouriteView) {[
            $0.widthAnchor.constraint(equalToConstant: Consts.Size.favourite),
            $0.heightAnchor.constraint(equalToConstant: Consts.Size.favourite),
        ]})

        NSLayoutConstraint.activate(F.apply((leadingStack, Consts.baseSize)) { stack, size in [
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: size),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: size),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: size),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: contentView.centerXAnchor, constant: Consts.halfBaseSize)
        ]})

        NSLayoutConstraint.activate(F.apply(trailingStack) {[
            $0.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Consts.baseSize),
            $0.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.centerXAnchor, constant: Consts.halfBaseSize)
        ]})
    }
}

extension QuoteCellTableViewCell {
    enum Consts {
        static let tinyEdge: CGFloat = 2
        static let baseSize: CGFloat = 24
        static let halfBaseSize = baseSize / 2

        enum Size {
            static let percent = Consts.baseSize * 2
            static let favourite = Consts.baseSize * 2
        }
    }
}
