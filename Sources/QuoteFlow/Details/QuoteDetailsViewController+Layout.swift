//
//  File.swift
//  
//
//  Created by Oleksii Hordiienko on 20.03.2023.
//

import UIKit
import Utils

extension QuoteDetailsViewController {
    func horizontalConstraints(_ safeArea: UILayoutGuide) -> [[NSLayoutConstraint]] {
        [
            F.apply(symbolLabel) {[
                $0.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Consts.Leading.symbolLabel),
                $0.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: Consts.Trailing.symbolLabel),
            ]},
            F.apply(nameLabel) {[
                $0.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Consts.Leading.nameLabel),
                $0.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: Consts.Trailing.nameLabel),
            ]},
            F.apply(lastLabel) {[
                $0.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Consts.Leading.lastLabel),
                $0.widthAnchor.constraint(equalToConstant: Consts.Width.lastLabel),
            ]},
            F.apply(currencyLabel) {[
                $0.leadingAnchor.constraint(equalTo: lastLabel.trailingAnchor, constant: Consts.Leading.currencyLabel),
                $0.widthAnchor.constraint(equalToConstant: Consts.Width.currencyLabel),
            ]},
            F.apply(readableLastChangePercentLabel) {[
                $0.leadingAnchor.constraint(
                    equalTo: currencyLabel.trailingAnchor,
                    constant: Consts.Leading.readableLastChangePercentLabel
                ),
                $0.widthAnchor.constraint(equalToConstant: Consts.Width.readableLastChangePercentLabel),
            ]},
            F.apply(favoriteButton) {[
                $0.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
                $0.widthAnchor.constraint(equalToConstant: Consts.Width.favoriteButton),
            ]}
        ]
    }

    func verticalConstraints(_ safeArea: UILayoutGuide) -> [[NSLayoutConstraint]] {
        [
            F.apply(symbolLabel) {[
                $0.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: Consts.Top.symbolLabel),
                $0.heightAnchor.constraint(equalToConstant: Consts.Height.symbolLabel),
            ]},
            F.apply(nameLabel) {[
                $0.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: Consts.Top.nameLabel),
                $0.heightAnchor.constraint(equalToConstant: Consts.Height.nameLabel),
            ]},
            F.apply(lastLabel) {[
                $0.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Consts.Top.lastLabel),
                $0.heightAnchor.constraint(equalToConstant: Consts.Height.lastLabel),
            ]},
            F.apply(currencyLabel) {[
                $0.topAnchor.constraint(equalTo: lastLabel.topAnchor),
                $0.heightAnchor.constraint(equalToConstant: Consts.Height.currencyLabel),
            ]},
            F.apply(readableLastChangePercentLabel) {[
                $0.topAnchor.constraint(equalTo: lastLabel.topAnchor),
                $0.bottomAnchor.constraint(equalTo: lastLabel.bottomAnchor),
            ]},
            F.apply(favoriteButton) {[
                $0.topAnchor.constraint(equalTo: readableLastChangePercentLabel.bottomAnchor, constant: Consts.Top.favoriteButton),
                $0.heightAnchor.constraint(equalToConstant: Consts.Height.favoriteButton),
            ]}
        ]
    }
}
