import UIKit
import SnapKit

///
/// Optional View to let users use Age as well, does currently affect the Result view,
/// would need to update SnapKit constraints
///
class AgeInputView: UIView {

    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(
            topText: "Input",
            bottomText: "age")
        return view
    }()
    
    private let textFieldContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addCornerRadius(radius: 12)
        return view
    }()
    
    /// Input box for user age
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = ThemeFont.bold(ofSize: 28)
        textField.keyboardType = .decimalPad
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.tintColor = ThemeColor.text
        textField.textColor = ThemeColor.primary

        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 36))
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(doneButtonClicked))
        toolBar.items = [
            UIBarButtonItem(
                barButtonSystemItem: .flexibleSpace,
                target: nil,
                action: nil),
            doneButton]
        
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        return textField
    }()
    
    /// Stepper button to increase and decrease age
    private let stepperInput: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.maximumValue = 100
        stepper.stepValue = 1
        stepper.addTarget(AgeInputView.self, action: #selector(stepperValueChanged), for: .valueChanged)
        return stepper
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Customize the appearance of the current view
    private func layout() {
        addSubview(headerView)
        addSubview(textFieldContainerView)
        addSubview(stepperInput)
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(textFieldContainerView.snp.centerY)
            make.width.equalTo(68)
            make.trailing.equalTo(textFieldContainerView.snp.leading).offset(-24)
        }
        
        textFieldContainerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(headerView.snp.trailing).offset(24)
            make.width.equalTo(130)
        }
        
        textFieldContainerView.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        
        stepperInput.snp.makeConstraints { make in
            make.leading.equalTo(textFieldContainerView.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
        
        addShadow(
            offset: CGSize(width: 0, height: 3),
            color: UIColor.black,
            radius: 12.0,
            opacity: 0.2)
    }

    /// Replaces the value in the stepper as the value changes
    @objc private func stepperValueChanged() {
        textField.text = String(Int(stepperInput.value))
    }
    
    /// Dismisses the keyboard when the 'Done' button is pressed
    @objc private func doneButtonClicked() {
        textField.endEditing(true)
    }
}
