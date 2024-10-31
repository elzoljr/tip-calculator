//
//  AmoutView.swift
//  tip-calculator
//
//  Created by Elzo Lourenço Júnior on 27/02/24.
//

import UIKit

class AmoutView: UIView {
    
    private let title: String
    private let textAlign: NSTextAlignment
    private let amountLabelIdentifier: String
    
    private lazy var titleLabel: UILabel = {
        LabelFactory.build(
            text: title,
            font: ThemeFont.regular(ofSize: 18),
            textColor: ThemeColor.text,
            textAlignment: textAlign
        )
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = textAlign
        label.textColor = ThemeColor.primary
        let text = NSMutableAttributedString(
            string: "R$ 0",
            attributes: [
                .font: ThemeFont.bold(ofSize: 24)
            ])
        text.addAttributes([
                .font: ThemeFont.bold(ofSize: 16)],
            range: NSMakeRange(0, 2))
        label.attributedText = text
        label.accessibilityIdentifier = amountLabelIdentifier
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            amountLabel
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    init(title: String, textAligment: NSTextAlignment, amountLabelIdentifier: String){
        self.title = title
        self.textAlign = textAligment
        self.amountLabelIdentifier = amountLabelIdentifier
        super.init(frame: .zero)
        layout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
       addSubview(stackView)
        stackView.snp.makeConstraints {make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(amout: Double) {
        let text = NSMutableAttributedString(
            string: String(amout.currencyFormatted).removeWhitespace,
            attributes: [
                .font: ThemeFont.bold(ofSize: 24)
            ])
        text.addAttributes([
                .font: ThemeFont.bold(ofSize: 16)],
            range: NSMakeRange(0, 2))
        amountLabel.attributedText = text
    }
}
