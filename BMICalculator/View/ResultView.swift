//
//  ResultView.swift
//  BMICalculator
//
//  Created by Matthew Travers on 6/7/24.
//

import UIKit

class ResultView: UIView {
    
    private let headerLabel: UILabel = {
        Label.build(
            text: "Your BMI Index",
            font: ThemeFont.demibold(ofSize: 18))
    }()
    
    private var totalBMI: UILabel = {
        Label.build(text: "- - -", font: ThemeFont.bold(ofSize: 48), textColor: ThemeColor.primary)
    }()
    
    private let horizontalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.separator
        return view
    }()
    
    private var yourWeight: AmountView = {
        return AmountView(title: "Your Weight", textAlignment: .left)
    }()
    
    private var yourHeight: AmountView = {
        return AmountView(title: "Your Height", textAlignment: .right)
    }()
    
    /// Horizontally stack height and weight information
    private lazy var hStackView: UIView = {
        let stackView = UIStackView(arrangedSubviews: [
            yourWeight,
            UIView(),
            yourHeight
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    /// Vertically stack the result information displayed to user
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            headerLabel,
            totalBMI,
            horizontalLineView,
            buildSpacerView(height: 0),
            hStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Resets 'Your BMI Index'' to initial values
    func reset() {
        totalBMI.text = "- - -"
        yourWeight.configure(text: "0.0")
        yourHeight.configure(text: "0.0")
    }
    
    /// Configures the result view with calculated values after computation
    ///
    /// ** Params:
    ///     - result: the result returned from the BMI calculation
    func configure(result: Result) {
        let bmiText = String(format: "%.2f", result.BMIIndex)
        totalBMI.attributedText = NSMutableAttributedString(
            string: bmiText,
            attributes: [.font : ThemeFont.bold(ofSize: 48), .foregroundColor : ThemeColor.primary]
        )
        yourWeight.configure(text: String(result.yourWeight))
        yourHeight.configure(text: String(result.yourHeight))
    }
    
    /// Customize the appearance of the current view
    private func layout() {
        backgroundColor = .white
        addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(24)
            make.leading.equalTo(snp.leading).offset(24)
            make.trailing.equalTo(snp.trailing).offset(-24)
            make.bottom.equalTo(snp.bottom).offset(-24)
        }
        horizontalLineView.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
        addShadow(
            offset: CGSize(width: 0, height: 3),
            color: UIColor.black,
            radius: 12.0,
            opacity: 0.2)
    }
    
    /// Creates a spacer block to nest between views
    ///
    /// ** Params:
    ///     - height: height of the customized spacer
    /// ** Returns:
    ///     - UIView: the spacer as a view
    private func buildSpacerView(height: CGFloat) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }
}
