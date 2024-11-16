//
//  HoldingCell.swift
//  UpstoxHolding
//
//  Created by Aditya Tyagi on 17/11/24.
//

import Foundation
import UIKit

final class HoldingCell: UITableViewCell {
    private var data: UserHolding? {
        didSet {
            setupUI()
        }
    }

    lazy private var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.setup()
        stackView.distribution = .fill
        return stackView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellAppearance()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCellAppearance()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellAppearance()
    }

    override func prepareForReuse() {
        data = nil
    }

    func updateData(_ holding: UserHolding) {
        if data == nil {
            data = holding
        }
    }

    private func setupUI() {
        selectionStyle = .none
        mainStackView.removeAllArrangedSubviews()
        getHorizontalStackView().forEach { mainStackView.addArrangedSubview($0) }
        contentView.addSubview(mainStackView)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }

    private func getHorizontalStackView() -> [UIStackView] {
        return [createStackView(with: [.name, .ltp]),
                createStackView(with: [.netQty, .pnl])]
    }

    private func createStackView(with attributes: [HoldingCellAttribute]) -> UIStackView {
        let stackView = UIStackView()
        stackView.setup(.horizontal)
        stackView.distribution = .equalSpacing
        attributes.compactMap { getLabel($0) }.forEach { stackView.addArrangedSubview($0) }
        return stackView
    }

    private func getLabel(_ attributeType: HoldingCellAttribute) -> UILabel? {
        guard let data else { return nil }
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = attributeType.attributedTitle(data)
//        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }

    private func setupCellAppearance() {
        contentView.backgroundColor = .systemBackground // Funky background color
        contentView.layer.cornerRadius = 10 // Rounded corners
        contentView.layer.shadowColor = UIColor.secondaryLabel.cgColor // Shadow color
        contentView.layer.shadowOpacity = 0.5 // Shadow opacity
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2) // Shadow offset
        contentView.layer.shadowRadius = 4 // Shadow radius

        // Add spacing between cells
        contentView.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    deinit {
        print("deinit called for :\(String(describing: self))")
    }
}
