//
//  StatusInputView.swift
//  BMICalculator
//
//  Created by Matthew Travers on 6/7/24.
//
import UIKit

class StatusInputView: UIView {
    
    private let weightStatus: UILabel = {
        Label.build(text: "Weight Status", font: ThemeFont.demibold(ofSize: 24))
    }()
    
    private let horizontalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.separator
        return view
    }()
    
    private let statusLabel: UILabel = {
        let label = Label.build(text: "- - - - - - - - - - -", font: ThemeFont.demibold(ofSize: 24))
        return label
    }()

    private let iconImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "health"))
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true

        return view
    }()
    
    private let textFieldContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addCornerRadius(radius: 12)
        return view
    }()
    
    /// Horizontally stacks image and status label
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            iconImageView,
            statusLabel
        ])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    /// Vertically stacks information for 'Weight Status' view
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            weightStatus,
            horizontalLineView,
            buildSpacerView(height: 8),
            hStackView,
            buildSpacerView(height: 8)
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Resets 'Weight Status'' to initial values
    func reset() {
        iconImageView.image = UIImage(named: "health")
        statusLabel.text = "- - - - - - - - - - -"
        statusLabel.textColor = .black
    }
    
    /// Organizes the layout for the 'Weight Status' box aligning the title, image, and health indicator
    private func layout() {
        backgroundColor = .white
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        horizontalLineView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(64)
        }
        
        textFieldContainerView.snp.makeConstraints { make in
            make.height.equalTo(64)
        }
        
        addShadow(
            offset: CGSize(width: 0, height: 3),
            color: UIColor.black,
            radius: 12.0,
            opacity: 0.2)
    }
    
    /// Spacer between 'Weight Status' and height input for user
    ///
    /// ** Params:
    ///     - height: designated height for spacer between views
    /// ** Returns:
    ///     - UIView of customized height
    private func buildSpacerView(height: CGFloat) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }
    
    /// Updates the 'Weight Status' box with health information according to national standards
    ///
    /// ** Params:
    ///     - bmi: BMI input by user, used for health calculations
    /// ** Returns:
    ///     - updated status box with health message
    func updateStatus(bmi: Double) {
        var statusText: String
        var iconImage: UIImage
        var statusColor: UIColor
        
        switch bmi {
        case ..<18.5:
            statusText = "Underweight"
            iconImage = UIImage(named: "underweight")!
            statusColor = UIColor.yellow
        case 18.5..<25:
            statusText = "Healthy"
            iconImage = UIImage(named: "healthy")!
            statusColor = UIColor.green
        case 25..<29.9:
            statusText = "Overweight"
            iconImage = UIImage(named: "overweight")!
            statusColor = UIColor.orange
        default:
            statusText = "Obese"
            iconImage = UIImage(named: "obese")!
            statusColor = UIColor.red
        }
        
        statusLabel.text = statusText
        statusLabel.textColor = statusColor
        iconImageView.image = iconImage
    }
}
