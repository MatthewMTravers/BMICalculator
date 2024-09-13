//
//  CalculatorViewModel.swift
//  BMICalculator
//
//  Created by Matthew Travers on 6/13/24.
//

import Foundation
import Combine
import Darwin   /// Needed for Math functions "pow"

class CalculatorViewModel {
    
    struct Input {
        let weightPublisher: AnyPublisher<Double, Never>
        let heightPublisherFeet: AnyPublisher<Int, Never>
        let heightPublisherInch: AnyPublisher<Int, Never>
        let logoRefreshTapPublisher: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher<Result, Never>
        let resetCalculatorPublisher: AnyPublisher<Void, Never>
    }
    
    private let audioPlayerService: AudioPlayerService
    
    init(audioPlayerService: AudioPlayerService = DefaultAudioPlayer()) {
        self.audioPlayerService = audioPlayerService
    }
    
    /// Updates the View when any input value changes and also handles input reset functionality
    ///
    /// ** Params:
    ///     - input: struct of height, weight, and logo publishers
    /// ** Returns:
    ///     - struct of update and reset view publishers
    func transform(input: Input) -> Output {
        let updateViewPublisher = Publishers.CombineLatest3(
            input.weightPublisher,
            input.heightPublisherFeet,
            input.heightPublisherInch).flatMap { [unowned self] (weight, feet, inch) in
                
                let inches = (feet * 12) + (inch > 0 ? inch : 0)
                if inches == 0 {
                    return Just(Result(BMIIndex: 0.0, yourWeight: weight, yourHeight: 0.0))
                        .eraseToAnyPublisher()
                } else {
                    let bmi = getBMI(weight: weight, inch: inches)
                    let result = Result(
                        BMIIndex: bmi,
                        yourWeight: weight,
                        yourHeight: Double(inches)
                    )
                    return Just(result).eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
        
        let resetCalculatorPublisher = input.logoRefreshTapPublisher.handleEvents(receiveOutput: { [unowned self] in
            audioPlayerService.playSound()
        }).flatMap {
            return Just(())
        }.eraseToAnyPublisher()

        return Output(
            updateViewPublisher: updateViewPublisher,
            resetCalculatorPublisher: resetCalculatorPublisher
        )
    }
    
    /// Takes the height and weight of the user and outputs their BMI according to Imperial units
    ///
    /// ** Params:
    ///     - weight: user input weight value in pounds
    ///     - inch: user input height value converted to inches
    /// ** Returns:
    ///     - calculated BMI value
    private func getBMI(weight: Double, inch: Int) -> Double {
        return (weight / pow(Double(inch), 2)) * 703
    }
}
