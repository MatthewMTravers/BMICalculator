//
//  ResultView.swift
//  BMICalculator
//
//  Created by Matthew Travers on 6/7/24.
//

import UIKit

class AmountView: UIView {
    
    private let title: String
    private let textAlign: NSTextAlignment
    
    private lazy var titleLabel: UILabel = {
        Label.build(
            text: title,
            font: ThemeFont.regular(ofSize: 16),
            textColor: ThemeColor.text,
            textAlignment: textAlign)
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = textAlign
        label.textColor = ThemeColor.primary
        label.font = ThemeFont.bold(ofSize: 24)
        label.text = "0.0"
        return label
    }()

    /// Vertically stacks title and amount for user metrics
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
        titleLabel,
        amountLabel
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    init(title: String, textAlignment: NSTextAlignment) {
        self.title = title
        self.textAlign = textAlignment
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Update desired label to have a new value
    ///
    /// ** Params:
    ///     - text: string to be updated
    func configure(text: String) {
        let text = NSMutableAttributedString(string: text, attributes: [.font: ThemeFont.bold(ofSize: 24)])
        amountLabel.attributedText = text
    }
    
    /// Customize the appearance of the current view
    private func layout() {
        addSubview(vStackView)
        vStackView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}
