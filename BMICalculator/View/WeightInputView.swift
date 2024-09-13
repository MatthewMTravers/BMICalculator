//
//  WeightInputView.swift
//  BMICalculator
//
//  Created by Matthew Travers on 6/7/24.
//

import UIKit
import Combine
import CombineCocoa

class WeightInputView: UIView {
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(
            topText: "Input",
            bottomText: "weight")
        return view
    }()
    
    private let textFieldContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addCornerRadius(radius: 12)
        return view
    }()
    
    private let weightLabel: UILabel = {
        let label = Label.build(
            text: "lbs",
            font: ThemeFont.demibold(ofSize: 24),
            textAlignment: .right)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    /// Input box for user weight
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
    
    /// Entity the subscribers get weight information from when updated by user
    private var weightSubject: PassthroughSubject<Double, Never> = .init()
    var weightPublisher: AnyPublisher<Double, Never> {
        return weightSubject.eraseToAnyPublisher()
    }
    
    /// Memory managment device to manager subscribers, canceling when not needed
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        super.init(frame: .zero)
        layout()
        observe()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Resets 'Input weight'' to initial values
    func reset() {
        textField.text = nil
    }
    
    /// Subscribes to the publisher to receive weight input and sends the data to its respective subject
    private func observe() {
        textField.textPublisher.sink { [unowned self] text in
            weightSubject.send(text?.doubleValue ?? 0)
        }.store(in: &cancellables)
    }
    
    /// Customize the appearance of the current view
    private func layout() {
        addSubview(headerView)
        addSubview(textFieldContainerView)
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(textFieldContainerView.snp.centerY)
            make.width.equalTo(68)
            make.trailing.equalTo(textFieldContainerView.snp.leading).offset(-24)
        }
        
        textFieldContainerView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalTo(headerView.snp.trailing).offset(24)
        }
        
        textFieldContainerView.addSubview(weightLabel)
        textFieldContainerView.addSubview(textField)
        
        weightLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
        
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(weightLabel.snp.leading).offset(-16)
        }
        
        addShadow(
            offset: CGSize(width: 0, height: 3),
            color: UIColor.black,
            radius: 12.0,
            opacity: 0.2)
    }
    
    /// Dismisses the keyboard when the 'Done' button is pressed
    @objc private func doneButtonClicked() {
        textField.endEditing(true)
    }
}

