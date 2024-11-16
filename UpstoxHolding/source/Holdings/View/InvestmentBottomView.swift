//
//  InvestmentBottomView.swift
//  UpstoxHolding
//
//  Created by Aditya Tyagi on 17/11/24.
//

import Foundation
import UIKit

final class InvestmentBottomView: UIView {
    var holdings: Holdings? {
        didSet {
            setupMainStackView()
        }
    }

    var viewState: BottomViewState = .collapsed {
        didSet {
            collpasedStackView.isHidden = !(viewState == .collapsed)
            expandedStackView.isHidden = !(viewState == .expanded)
        }
    }
    lazy private var collpasedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.setup(.vertical, 16)
        return stackView
    }()

    lazy private var expandedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.setup(.vertical, 16)
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        backgroundColor = Colors.bottomSheetBackground
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        setupConstraints()
    }

    private func setupConstraints() {
        addSubview(collpasedStackView)
        addSubview(expandedStackView)
        NSLayoutConstraint.activate([
            collpasedStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collpasedStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            collpasedStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            expandedStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            expandedStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            expandedStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
    
    private func setupMainStackView() {
        collpasedStackView.removeAllArrangedSubviews()
        expandedStackView.removeAllArrangedSubviews()
        getHorizontalStackView(for: .collapsed).forEach { collpasedStackView.addArrangedSubview($0) }
        getHorizontalStackView(for: .expanded).forEach { expandedStackView.addArrangedSubview($0) }
        expandedStackView.isHidden = true
    }

    private func getHorizontalStackView(for state: BottomViewState) -> [UIStackView] {
        let viewAttributes: [InvestmentViewAttributes] =
        state == .collapsed ? [.pnl] : [.currentInvestment, .totalInvestment, .todayPnl, .pnl]
        return viewAttributes.compactMap {
            let stackView = UIStackView()
            stackView.setup(.horizontal, 16)
            stackView.distribution  = .equalSpacing
            getLabels(for: $0, state).forEach { stackView.addArrangedSubview($0) }
            return stackView
        }
    }

    private func getLabels(for attributes: InvestmentViewAttributes,
                           _ state: BottomViewState) -> [UILabel] {
        let firstLabel = UILabel()
        let firstLabelText = attributes.attributedTitle
        if attributes == .pnl {
            firstLabelText.appendIcon(state.imageName)
        }
        firstLabel.attributedText = firstLabelText
        let secondLabel = UILabel()
        secondLabel.attributedText = attributes.secondLabelAttributeTitle(for: holdings)
        return [firstLabel, secondLabel]
    }

    deinit {
        print("deinit called for :\(String(describing: self))")
    }
}
