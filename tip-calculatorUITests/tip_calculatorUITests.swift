//
//  tip_calculatorUITests.swift
//  tip-calculatorUITests
//
//  Created by Elzo Lourenço Júnior on 20/02/24.
//

import XCTest

final class tip_calculatorUITests: XCTestCase {
    
    private var app: XCUIApplication!
    private var screen: CalculatorScreen {
        CalculatorScreen(app: app)
    }
    
    override func setUp() {
        super.setUp()
        app = .init()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    func testRegularTip() {
        screen.enterBill(amount: 100)
        XCTAssertEqual(screen.totalAmoutPerPersonValueLabel.label, "R$ 100")
        XCTAssertEqual(screen.totalBillValueLabel.label, "R$ 100")
        XCTAssertEqual(screen.totalTipValueLabel.label, "R$ 0")

        screen.selectTip(tip: .tenPercent)
        XCTAssertEqual(screen.totalAmoutPerPersonValueLabel.label, "R$ 110")
        XCTAssertEqual(screen.totalBillValueLabel.label, "R$ 110")
        XCTAssertEqual(screen.totalTipValueLabel.label, "R$ 10")

        screen.selectTip(tip: .fifteenPercent)
        XCTAssertEqual(screen.totalAmoutPerPersonValueLabel.label, "R$ 115")
        XCTAssertEqual(screen.totalBillValueLabel.label, "R$ 115")
        XCTAssertEqual(screen.totalTipValueLabel.label, "R$ 15")

        screen.selectTip(tip: .twentyPercent)
        XCTAssertEqual(screen.totalAmoutPerPersonValueLabel.label, "R$ 120")
        XCTAssertEqual(screen.totalBillValueLabel.label, "R$ 120")
        XCTAssertEqual(screen.totalTipValueLabel.label, "R$ 20")
        
        screen.selectIncrementButton(numberOfTaps: 2)
        XCTAssertEqual(screen.totalAmoutPerPersonValueLabel.label, "R$ 40")
        XCTAssertEqual(screen.totalBillValueLabel.label, "R$ 120")
        XCTAssertEqual(screen.totalTipValueLabel.label, "R$ 20")
        
        screen.selectDecrementButton(numberOfTaps: 1)
        XCTAssertEqual(screen.totalAmoutPerPersonValueLabel.label, "R$ 60")
        XCTAssertEqual(screen.totalBillValueLabel.label, "R$ 120")
        XCTAssertEqual(screen.totalTipValueLabel.label, "R$ 20")
    }
    
    
    func testCustomTipAndSplitBillBy2(){
        screen.enterBill(amount: 300)
        screen.selectTip(tip: .custom(value: 200))
        screen.selectIncrementButton(numberOfTaps: 1)
        XCTAssertEqual(screen.totalAmoutPerPersonValueLabel.label, "R$ 250")
        XCTAssertEqual(screen.totalBillValueLabel.label, "R$ 500")
        XCTAssertEqual(screen.totalTipValueLabel.label, "R$ 200")
    }
    
    
    func testResetButton(){
        screen.enterBill(amount: 300)
        screen.selectTip(tip: .custom(value: 200))
        screen.selectIncrementButton(numberOfTaps: 1)
        screen.doubleTapLogoView()
        XCTAssertEqual(screen.totalAmoutPerPersonValueLabel.label, "R$ 0")
        XCTAssertEqual(screen.totalBillValueLabel.label, "R$ 0")
        XCTAssertEqual(screen.totalTipValueLabel.label, "R$ 0")
        
        XCTAssertEqual(screen.billInputViewTextField.label, "")
        XCTAssertEqual(screen.splitValueLabel.label, "1")
        XCTAssertEqual(screen.customTipButton.label, "Custom Tip")
        
    }
    
    func testResultViewDefaultValues() {
        XCTAssertEqual(screen.totalAmoutPerPersonValueLabel.label, "R$ 0")
        XCTAssertEqual(screen.totalBillValueLabel.label, "R$ 0")
        XCTAssertEqual(screen.totalTipValueLabel.label, "R$ 0")
    }
}
