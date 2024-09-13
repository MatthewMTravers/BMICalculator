//
//  LogoView.swift
//  BMICalculator
//
//  Created by Matthew Travers on 6/7/24.
//

import UIKit

class LogoView: UIView {
    
    private let imageView: UIImageView = {
        let view = UIImageView(image: .init(named: "health"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(
            string: "BMI",
            attributes: [.font: ThemeFont.demibold(ofSize: 16)])
        label.attributedText = text
        return label
    }()
    
    private let bottomLabel: UILabel = {
        Label.build(
            text: "Calculator",
            font: ThemeFont.demibold(ofSize: 20),
            textAlignment: .left)
    }()
    
    /// Vertically stack the labels that make up the title
    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            topLabel,
            bottomLabel
        ])
        view.axis = .vertical
        view.spacing = -4
        return view
    }()
    
    /// Horizontally stack the title and the image to make the header
    private lazy var hStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
        imageView,
        vStackView
        ])
        view.axis = .horizontal
        view.spacing = 8
        view.alignment = .center
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Organizes the logo and app title on the page, constraining them to the top
    private func layout() {
        addSubview(hStackView)
        hStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.height.equalTo(imageView.snp.width)
        }
    }
}
