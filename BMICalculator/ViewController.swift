//
//  ViewController.swift
//  BMICalculator
//
//  Created by Matthew Travers on 6/7/24.
//
//  https://www.flaticon.com/free-icons/skinny Skinny icons created by Marcus Christensen - Flaticon
//  https://www.flaticon.com/free-icons/healthy Healthy icons created by Freepik - Flaticon
//  https://www.flaticon.com/free-icons/fat Fat icons created by Freepik - Flaticon
//  https://www.flaticon.com/free-icons/obesity Obesity icons created by Leremy - Flaticon
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class BMICalculatorVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind()
        observe()
    }
    
    /// Binds user input publishers to the view model and updates/resets the views based on output publishers
    private func bind() {
        let input = CalculatorViewModel.Input(
            weightPublisher: weightInputView.weightPublisher,
            heightPublisherFeet: heightInputView.heightPublisherFeet,
            heightPublisherInch: heightInputView.heightPublisherInches,
            logoRefreshTapPublisher: logoRefreshTapPublisher)
        
        let output = vm.transform(input: input)
        
        output.updateViewPublisher.sink { [unowned self] result in
            resultView.configure(result: result)
            statusInputView.updateStatus(bmi: result.BMIIndex)
        }.store(in: &cancellables)
        
        output.resetCalculatorPublisher.sink { [unowned self] result in
            resultView.reset()
            weightInputView.reset()
            heightInputView.reset()
            statusInputView.reset()
        }.store(in: &cancellables)
    }
    
    /// Subscribes to the publisher to receive user tap input and send the data to its respective view
    private func observe() {
        viewTapPublisher.sink { [unowned self] value in
            view.endEditing(true)
        }.store(in: &cancellables)
    }
    
    private let logoView = LogoView()
    private let resultView = ResultView()
    private let weightInputView = WeightInputView()
    private let heightInputView = HeightInputView()
    private let statusInputView = StatusInputView()
    //private let ageInputView = AgeInputView()
    
    /// Stack all views vertically to fit into vertical phone screen
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            logoView,
            resultView,
            weightInputView,
            heightInputView,
            statusInputView,
            //ageInputView,
            UIView()
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 36
        return stackView
    }()
    
    private let vm = CalculatorViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var viewTapPublisher: AnyPublisher<Void, Never> = {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        view.addGestureRecognizer(tapGesture)
        return tapGesture.tapPublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()
    
    private lazy var logoRefreshTapPublisher: AnyPublisher<Void, Never> = {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        tapGesture.numberOfTapsRequired = 1
        logoView.addGestureRecognizer(tapGesture)
        return tapGesture.tapPublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()
    
    /// Adds spacing to all views to organize them on home page
    private func layout() {
        view.backgroundColor = ThemeColor.bg
        view.addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leadingMargin).offset(16)
            make.trailing.equalTo(view.snp.trailingMargin).offset(-16)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-16)
            make.top.equalTo((view.snp.topMargin)).offset(16)
        }
        
        logoView.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        resultView.snp.makeConstraints { make in
            make.height.equalTo(224)
        }
        weightInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        heightInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }

        statusInputView.snp.makeConstraints { make in
            make.height.equalTo(168)
        }
        
        //ageInputView.snp.makeConstraints { make in
        //    make.height.equalTo(56)
        //}
    }
}
