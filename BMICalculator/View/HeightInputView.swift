//
//  HeightInputView.swift
//  BMICalculator
//
//  Created by Matthew Travers on 6/7/24.
//

import UIKit
import Combine
import CombineCocoa

class HeightInputView: UIView {
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(
            topText: "Input",
            bottomText: "height")
        return view
    }()
    
    private let textFieldContainerViewFeet: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addCornerRadius(radius: 12)
        return view
    }()
    
    private let textFieldContainerViewInch: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addCornerRadius(radius: 12)
        return view
    }()
    
    private let feetLabel: UILabel = {
        let label = Label.build(
            text: "ft",
            font: ThemeFont.demibold(ofSize: 24),
            textAlignment: .right)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private let inchLabel: UILabel = {
        let label = Label.build(
            text: "inch",
            font: ThemeFont.demibold(ofSize: 24),
            textAlignment: .right)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    /// Input box for user height in feet
    private lazy var textFieldFeet: UITextField = {
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
    
    /// Input box for remaing user height in inches
    private lazy var textFieldInches: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = ThemeFont.bold(ofSize: 28)
        textField.keyboardType = .decimalPad
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.tintColor = ThemeColor.text
        textField.textColor = ThemeColor.primary
        
        // Toolbar for user input
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
    
    /// Subject to pass newly input values to subscribers
    private var heightSubjectFeet: PassthroughSubject<Int, Never> = .init()
    private var heightSubjectInch: PassthroughSubject<Int, Never> = .init()

    /// Entity the subscribers get height information from when updated by user
    var heightPublisherFeet: AnyPublisher<Int, Never> {
        return heightSubjectFeet.eraseToAnyPublisher()
    }
    var heightPublisherInches: AnyPublisher<Int, Never> {
        return heightSubjectInch.eraseToAnyPublisher()
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
    
    /// Resets 'Input height'' to initial values
    func reset() {
        textFieldFeet.text = nil
        textFieldInches.text = nil
    }
    
    /// Subscribes to the publishers to receive height input and sends the data to their respective subjects
    private func observe() {
        textFieldFeet.textPublisher.sink { [unowned self] text in
            heightSubjectFeet.send(text?.intValue ?? 0)
        }.store(in: &cancellables)
        
        textFieldInches.textPublisher.sink { [unowned self] text in
            heightSubjectInch.send(text?.intValue ?? 0)
        }.store(in: &cancellables)
    }
    
    /// Customize the appearance of the current view
    private func layout() {
        addSubview(headerView)
        addSubview(textFieldContainerViewFeet)
        addSubview(textFieldContainerViewInch)
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(textFieldContainerViewFeet.snp.centerY)
            make.width.equalTo(68)
            make.trailing.equalTo(textFieldContainerViewFeet.snp.leading).offset(-24)
        }
        
        textFieldContainerViewFeet.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(headerView.snp.trailing).offset(24)
            make.width.equalTo(88)
        }
        
        textFieldContainerViewFeet.addSubview(feetLabel)
        textFieldContainerViewFeet.addSubview(textFieldFeet)
        
        feetLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            
        }
        
        textFieldFeet.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(feetLabel.snp.leading).offset(-8)
        }
        
        textFieldContainerViewInch.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(textFieldContainerViewFeet.snp.trailing).offset(16)
            make.width.equalTo(105)
            make.trailing.equalToSuperview()
        }
        
        textFieldContainerViewInch.addSubview(inchLabel)
        textFieldContainerViewInch.addSubview(textFieldInches)
        
        inchLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
        
        textFieldInches.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(inchLabel.snp.leading).offset(-8)
        }
        
        addShadow(
            offset: CGSize(width: 0, height: 3),
            color: UIColor.black,
            radius: 12.0,
            opacity: 0.2)
    }
    
    /// Dismisses the keyboard when the 'Done' button is pressed
    @objc private func doneButtonClicked() {
        textFieldFeet.endEditing(true)
        textFieldInches.endEditing(true)
    }
}
