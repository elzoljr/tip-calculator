//
//  CalculatorVM.swift
//  tip-calculator
//
//  Created by Elzo Lourenço Júnior on 29/02/24.
//

import Foundation
import Combine

class CalculatorVM {
    
    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
        let logoViewPublisher: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher<Result, Never>
        let resetCalculatorPublisher:  AnyPublisher<Void, Never>
    }
    
    private var cancellables = Set<AnyCancellable>()
    private let audioPlayerService: AudioPlayerService
    
    init(audioPlayerService: AudioPlayerService = DefaultAudioPlayer()) {
        self.audioPlayerService = audioPlayerService
    }
    
    
    func transform(input: Input) -> Output {
        let updateViewPublisher = Publishers.CombineLatest3(
            input.billPublisher,
            input.tipPublisher,
            input.splitPublisher).flatMap { [unowned self] (bill, tip, split) in
                let totalTip = getTipAmout(bill: bill, tip: tip)
                let totalBil = bill + totalTip
                let amountPerPerson = totalBil / Double(split)
                let result = Result(
                    amoutPerPerson: amountPerPerson,
                    totalBill: totalBil,
                    totalTip: totalTip
                )
                return Just(result)
            }.eraseToAnyPublisher()
        
        let  resultCalculatorPublisher = input.logoViewPublisher.handleEvents(receiveOutput: { [unowned self] in
            audioPlayerService.playSound()
        }).flatMap {
            return Just($0)
        }.eraseToAnyPublisher()
        
        return Output(updateViewPublisher: updateViewPublisher, resetCalculatorPublisher: resultCalculatorPublisher)
    }
    
    private func getTipAmout(bill: Double, tip: Tip) -> Double{
        switch tip {
        case .none:
           return 0
        case .tenPercent:
            return bill * 0.1
        case .fifteenPercent:
            return bill * 0.15
        case .twentyPercent:
            return bill * 0.20
        case .custom(value: let value):
            return Double(value)
        }
    }
}
