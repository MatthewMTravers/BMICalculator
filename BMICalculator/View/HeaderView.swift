//
//  HeaderView.swift
//  BMICalculator
//
//  Created by Matthew Travers on 6/12/24.
//

import UIKit

class HeaderView: UIView {
    
    private let topLabel: UILabel = {
        Label.build(
            text: nil,
            font: ThemeFont.bold(ofSize: 22))
    }()
    
    private let bottomLabel: UILabel = {
        Label.build(
            text: nil,
            font: ThemeFont.regular(ofSize: 18))
    }()
    
    private let topSpacerView = UIView()
    private let bottomSpacerView = UIView()
    
    /// Vertical stack view to create custom headers
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
        topSpacerView,
        topLabel,
        bottomLabel,
        bottomSpacerView
        ])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = -4
        return stackView
    }()

    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Customize the appearance of the current view
    private func layout() {
        addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        topSpacerView.snp.makeConstraints { make in
            make.height.equalTo(bottomSpacerView)
        }
    }
    
    /// Creates the header with customized text
    ///
    /// ** Params:
    ///     - topText: upper header, larger
    ///     - bottomText:  lower header, smaller
    func configure(topText: String, bottomText: String) {
        topLabel.text = topText
        bottomLabel.text = bottomText
    }
}

