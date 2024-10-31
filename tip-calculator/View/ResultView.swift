//
//  ResultView.swift
//  tip-calculator
//
//  Created by Elzo Lourenço Júnior on 22/02/24.
//

import UIKit

class ResultView: UIView {
    
    typealias Identifier = ScreenIdentifier.ResultView
    
    private let headerLabel: UILabel = {
        LabelFactory.build(
            text: "Total p/ person",
            font: ThemeFont.demibold(ofSize: 18)
        )
    }()
    
    private let amountPerPersonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let text = NSMutableAttributedString(
            string: "R$ 0",
            attributes: [
                .font: ThemeFont.bold(ofSize: 48)
            ])
        text.addAttributes([
            .font: ThemeFont.bold(ofSize: 24)
        ], range: NSMakeRange(0, 2))
        label.attributedText = text
        label.accessibilityIdentifier = ScreenIdentifier.ResultView.totalAmoutPerPersonValueLabel.rawValue
        return label
    }()
    
    private let horizontalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.separator
        return view
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView( arrangedSubviews: [
            headerLabel,
            amountPerPersonLabel,
            horizontalLineView,
            buildSpacerView(height: 0),
            hStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    private var totalBillAmount = AmoutView(
        title: "Total bill",
        textAligment: .left,
        amountLabelIdentifier: Identifier.totalBillValueLabel.rawValue
    )
    
    private var totalTipAmount = AmoutView(
        title: "Total tip",
        textAligment: .right,
        amountLabelIdentifier: Identifier.totalTipValueLabel.rawValue
    )
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView( arrangedSubviews: [
            totalBillAmount,
            totalTipAmount
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    
    init() {
        super.init(frame: .zero)
        accessibilityIdentifier = ScreenIdentifier.LogoView.logoView.rawValue
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(result: Result) {
        let text = NSMutableAttributedString(
            string: String(result.amoutPerPerson.currencyFormatted).removeWhitespace,
            attributes: [.font: ThemeFont.bold(ofSize: 48)]
        )
        text.addAttributes([
            .font: ThemeFont.bold(ofSize: 24)
        ], range: NSMakeRange(0, 2))
        amountPerPersonLabel.attributedText = text
        totalBillAmount.configure(amout: result.totalBill)
        totalTipAmount.configure(amout:  result.totalTip)
    }
    
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
            color: .black,
            radius: 12.0,
            opacity: 0.1)
    }
    
    private func buildSpacerView(height: CGFloat) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }
}
