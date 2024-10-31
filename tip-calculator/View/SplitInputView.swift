//
//  SplitInputView.swift
//  tip-calculator
//
//  Created by Elzo Lourenço Júnior on 22/02/24.
//

import UIKit
import Combine
import CombineCocoa

class SplitInputView: UIView {
    
    typealias Identifier = ScreenIdentifier.SplitInputView
    
    private let headerView : HeaderView = {
        let view = HeaderView()
        view.configure(topText: "Split", bottomText: "the total")
        return view
    }()
    
    private lazy var decrementButton: UIButton = {
        let button = buildButton(text: "-", corners: [.layerMinXMaxYCorner, .layerMinXMinYCorner])
        button.accessibilityIdentifier = Identifier.decrementButton.rawValue
        button.tapPublisher.flatMap { [unowned self] _ in
            Just(splitSubject.value != 1 ? splitSubject.value - 1 : 1)
        }.assign(to: \.value, on: splitSubject)
            .store(in: &cancellables)
        
        return button
    }()
    
    private lazy var incrementButton: UIButton = {
        let button = buildButton(text: "+", corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        button.accessibilityIdentifier = Identifier.incrementButton.rawValue
        button.tapPublisher.flatMap { [unowned self] _ in
            Just(splitSubject.value + 1)
        }.assign(to: \.value, on: splitSubject)
            .store(in: &cancellables)
        
        return button
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = LabelFactory.build(
            text: "1",
            font: ThemeFont.bold(ofSize: 20),
            backgroundColor: .white
        )
        
        label.accessibilityIdentifier = Identifier.quantityValueLabel.rawValue
        return label
    }()
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [
            decrementButton,
            quantityLabel,
            incrementButton
       ])
        stackView.axis = .horizontal
        stackView.spacing = 0
        
       return stackView
    }()
    
    
    private var cancellables = Set<AnyCancellable>()
    private let splitSubject = CurrentValueSubject<Int, Never>(1)
    var valuePublisher: AnyPublisher<Int, Never> {
        return splitSubject.removeDuplicates().eraseToAnyPublisher()
    }
    
    init() {
        super.init(frame: .zero)
        layout()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        [headerView, stackView].forEach(addSubview(_:))
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        [incrementButton, decrementButton].forEach { button in
            button.snp.makeConstraints { make in
                make.width.equalTo(button.snp.height)
            }
        }
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(stackView.snp.centerY)
            make.trailing.equalTo(stackView.snp.leading).offset(-24)
            make.width.equalTo(68)
        }
    }
    
    private func observe(){
        splitSubject.sink { [unowned self] quantity in
            quantityLabel.text = quantity.stringValue
        }.store(in: &cancellables)
    }
    
    private func buildButton(text: String, corners: CACornerMask) -> UIButton{
        let button = UIButton()
        button.backgroundColor = ThemeColor.primary
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.addRoundedCorners(conners: corners, radius: 8.0)
        return button
    }
    
    
    func reset() {
        splitSubject.send(1)
    }
    
}
