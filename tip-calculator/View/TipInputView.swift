//
//  TipInputView.swift
//  tip-calculator
//
//  Created by Elzo Lourenço Júnior on 22/02/24.
//

import UIKit
import Combine
import CombineCocoa

class TipInputView: UIView {
    
    typealias Identifier = ScreenIdentifier.TipInputView
    
    private let headerView : HeaderView = {
        let view = HeaderView()
        view.configure(topText: "Choose", bottomText: "your tip")
        return view
    }()
    
    private lazy var tenPercentTipButton : UIButton = {
        let button = buldTipButton(tip: .tenPercent)
        button.accessibilityIdentifier = Identifier.tenPercentButton.rawValue
        button.tapPublisher.flatMap({
            Just(Tip.tenPercent)
        }).assign(to: \.value, on: tipSubject)
        .store(in: &cancellables)
        return button
    }()
    
    private lazy var fifteenPercentTipButton : UIButton = {
        let button = buldTipButton(tip: .fifteenPercent)
        button.accessibilityIdentifier = Identifier.fifiteenPercentButton.rawValue
        button.tapPublisher.flatMap({
            Just(Tip.fifteenPercent)
        }).assign(to: \.value, on: tipSubject)
        .store(in: &cancellables)
        return button
    }()
    
    private lazy var twentyPercentTipButton : UIButton = {
        let button = buldTipButton(tip: .twentyPercent)
        button.accessibilityIdentifier = Identifier.twentyPercentButton.rawValue
        button.tapPublisher.flatMap({
            Just(Tip.twentyPercent)
        }).assign(to: \.value, on: tipSubject)
        .store(in: &cancellables)
        return button
    }()
    
    private lazy var customTipButton : UIButton = {
        let button = UIButton()
        button.setTitle("Custom tip", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.addCornerRadius(radius: 8.0)
        button.accessibilityIdentifier = Identifier.customButton.rawValue
        button.tapPublisher.sink{ [weak self] _ in
            self?.handleCustomTipButton()
        }.store(in: &cancellables)
        return button
    }()

    private lazy var buttonHStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            tenPercentTipButton,
            fifteenPercentTipButton,
            twentyPercentTipButton
        ])
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        return stackView
    }()
    
    private lazy var buttonVStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            buttonHStackView,
            customTipButton
        ])
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        return stackView
    }()
    
    private var cancellables = Set<AnyCancellable>()
    private let tipSubject = CurrentValueSubject<Tip, Never>(.none)
    var valuePublisher: AnyPublisher<Tip, Never> {
        return tipSubject.eraseToAnyPublisher()
    }
    
    init() {
        super.init(frame: .zero)
        observe()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        [headerView, buttonVStackView].forEach(addSubview(_:))
        
        buttonVStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(buttonVStackView.snp.leading).offset(-24)
            make.width.equalTo(68)
            make.centerY.equalTo(buttonHStackView.snp.centerY)
        }
        
    }
    
    private func handleCustomTipButton() {
        let alertController: UIAlertController = {
            let controller = UIAlertController(
                title: "Enter custom tip",
                message: "",
                preferredStyle: .alert
            )
            
            controller.addTextField { textFiled in
                textFiled.placeholder = "Make it generous!"
                textFiled.keyboardType = .numberPad
                textFiled.autocorrectionType = .no
                textFiled.accessibilityIdentifier = Identifier.customTipAlertTextField.rawValue
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                guard let text = controller.textFields?.first?.text, let value = Int(text) else {
                    return
                }
                self?.tipSubject.send(.custom(value: value))
            }
            
            [okAction,cancelAction].forEach(controller.addAction(_:))
            
            return controller
        }()
        
        parentViewController?.present(alertController, animated: true)
    }
    
    private func resetView(){
        [tenPercentTipButton, fifteenPercentTipButton, twentyPercentTipButton, customTipButton].forEach {
            $0.backgroundColor = ThemeColor.primary
        }
        
        let text = NSMutableAttributedString(
            string: "Custom Tip",
            attributes: [.font: ThemeFont.bold(ofSize: 20)]
        )
        customTipButton.setAttributedTitle(text, for: .normal)
    }
    
    private func observe(){
        tipSubject.sink { [unowned self] tip in
            resetView()
            switch tip {
            case .none:
                break
            case .tenPercent:
                tenPercentTipButton.backgroundColor = ThemeColor.secndary
            case .fifteenPercent:
                fifteenPercentTipButton.backgroundColor = ThemeColor.secndary
            case .twentyPercent:
                twentyPercentTipButton.backgroundColor = ThemeColor.secndary
            case .custom(value: let value):
                customTipButton.backgroundColor = ThemeColor.secndary
                let text = NSMutableAttributedString(
                    string: "$\(value)",
                    attributes: [.font: ThemeFont.bold(ofSize: 20)]
                )
                text.addAttributes([.font:ThemeFont.bold(ofSize: 14)], range: NSMakeRange(0, 1))
                customTipButton.setAttributedTitle(text, for: .normal)
            }
        }.store(in: &cancellables)
    }
    
    private func buldTipButton(tip: Tip) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.addCornerRadius(radius: 8.0)
        let text = NSMutableAttributedString(
            string: tip.stringValue,
            attributes: [
                .font: ThemeFont.bold(ofSize: 20),
                .foregroundColor: UIColor.white
            ])
        text.addAttributes([
            .font: ThemeFont.demibold(ofSize: 14)
        ], range: NSMakeRange(2, 1))
        button.setAttributedTitle(text, for: .normal)
        return button
    }
    
    func reset() {
        tipSubject.send(.none)
    }
}
