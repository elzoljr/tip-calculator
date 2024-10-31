//
//  CalculatorScreen.swift
//  tip-calculator
//
//  Created by Elzo Lourenço Júnior on 11/03/24.
//

import XCTest

class CalculatorScreen {
    
    typealias ResultViewIdentifier = ScreenIdentifier.ResultView
    typealias TipInputViewIdentifier = ScreenIdentifier.TipInputView
    typealias SplitViewIdentifier = ScreenIdentifier.SplitInputView
    
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    // LogoView
    var logoView: XCUIElement {
        return app.otherElements[ScreenIdentifier.LogoView.logoView.rawValue]
    }
    
    // ResultView
    var totalAmoutPerPersonValueLabel: XCUIElement {
        return app.staticTexts[ResultViewIdentifier.totalAmoutPerPersonValueLabel.rawValue]
    }
    
    var totalBillValueLabel: XCUIElement {
        return app.staticTexts[ResultViewIdentifier.totalBillValueLabel.rawValue]
    }
    
    var totalTipValueLabel: XCUIElement {
        return app.staticTexts[ResultViewIdentifier.totalTipValueLabel.rawValue]
    }
    
    //BillInputView
    var billInputViewTextField: XCUIElement {
        return app.textFields[ScreenIdentifier.BillInputView.textField.rawValue]
    }
    
    //TipInputView
    var tenPercentTipButton: XCUIElement {
        return app.buttons[TipInputViewIdentifier.tenPercentButton.rawValue]
    }
    
    var fifiteenPercentTipButton: XCUIElement {
        return app.buttons[TipInputViewIdentifier.fifiteenPercentButton.rawValue]
    }
    
    var twentyPercentTipButton: XCUIElement {
        return app.buttons[TipInputViewIdentifier.twentyPercentButton.rawValue]
    }
    
    var customTipButton: XCUIElement {
        return app.buttons[TipInputViewIdentifier.customButton.rawValue]
    }
    
    var customTipAlertTextField: XCUIElement {
        return app.textFields[TipInputViewIdentifier.customTipAlertTextField.rawValue]
    }
    

    //SplitInputView
    var incrementButton: XCUIElement {
        app.buttons[SplitViewIdentifier.incrementButton.rawValue]
    }
    
    var decrementButton: XCUIElement {
        app.buttons[SplitViewIdentifier.decrementButton.rawValue]
    }
    
    var splitValueLabel: XCUIElement {
        app.staticTexts[SplitViewIdentifier.quantityValueLabel.rawValue]
    }
    
    
    //Actions
    func enterBill(amount: Double) {
        billInputViewTextField.tap()
        billInputViewTextField.typeText("\(amount)\n")
    }
    
    func selectTip(tip: Tip) {
        switch tip{
        case .tenPercent:
            tenPercentTipButton.tap()
        case .fifteenPercent:
            fifiteenPercentTipButton.tap()
        case.twentyPercent:
            twentyPercentTipButton.tap()
        case .custom(let value):
            customTipButton.tap()
            XCTAssertTrue(customTipAlertTextField.waitForExistence(timeout: 1.0))
            customTipAlertTextField.typeText("\(value)\n")
        }
    }
    
    func selectIncrementButton(numberOfTaps: Int) {
        incrementButton.tap(withNumberOfTaps: numberOfTaps, numberOfTouches: 1)
    }
    
    func selectDecrementButton(numberOfTaps: Int) {
        decrementButton.tap(withNumberOfTaps: numberOfTaps, numberOfTouches: 1)
    }
    
    func doubleTapLogoView() {
        logoView.tap(withNumberOfTaps: 2, numberOfTouches: 1)
    }
    
    enum Tip {
        case tenPercent
        case fifteenPercent
        case twentyPercent
        case custom(value: Int)
    }
}

