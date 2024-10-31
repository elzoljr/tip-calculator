//
//  tip_calculatorSnapshootTests.swift
//  tip-calculatorTests
//
//  Created by Elzo Lourenço Júnior on 11/03/24.
//

import XCTest
import SnapshotTesting
@testable import tip_calculator

final class tip_calculatorSnapshootTests: XCTestCase {
    
    private var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    func testLogoView() {
        //give
        let size = CGSize(width: screenWidth, height: 48)
        //when
        let view = LogoView()
        //then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInitialResultView() {
        //give
        let size = CGSize(width: screenWidth, height: 224)
        //when
        let view = ResultView()
        //then
        assertSnapshot(matching: view, as: .image(size: size), record: false)
    }
    
    func testResultViewWithValues() {
        //give
        let size = CGSize(width: screenWidth, height: 224)
        let result =  Result(amoutPerPerson: 100.25, totalBill: 45, totalTip: 60)
        //when
        let view = ResultView()
        view.configure(result: result)
        //then
        assertSnapshot(matching: view, as: .image(size: size), record: false)
    }
    
    func testInitalBillInputView() {
        //give
        let size = CGSize(width: screenWidth, height: 56)
        //when
        let view = BillInputView()
        //then
        assertSnapshot(matching: view, as: .image(size: size), record: false)
    }
    
    func testBillInputViewWhithValue() {
        //give
        let size = CGSize(width: screenWidth, height: 56)
        //when
        let view = BillInputView()
        let textField = view.allSubViewsOf(type: UITextField.self).first
        textField?.text = "500"
        //then
        assertSnapshot(matching: view, as: .image(size: size), record: false)
    }
    
    func testInitialTipInputView() {
        //give
        let size = CGSize(width: screenWidth, height: 56+56+16)
        //when
        let view = TipInputView()
        //then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testTipInputViewWithValue() {
        //give
        let size = CGSize(width: screenWidth, height: 56+56+16)
        //when
        let view = TipInputView()
        let button = view.allSubViewsOf(type: UIButton.self).first
        button?.sendActions(for: .touchUpInside)
        //then
        assertSnapshot(matching: view, as: .image(size: size), record: false)
    }
    
    func testInitialSplitInputView() {
        //give
        let size = CGSize(width: screenWidth, height: 48)
        //when
        let view = SplitInputView()
        //then
        assertSnapshot(matching: view, as: .image(size: size), record: false)
    }
    
    func testSplitInputViewWithValue() {
        //give
        let size = CGSize(width: screenWidth, height: 48)
        //when
        let view = SplitInputView()
        let button = view.allSubViewsOf(type: UIButton.self).first
        button?.sendActions(for: .touchUpInside)
        //then
        assertSnapshot(matching: view, as: .image(size: size), record: false)
    }
}

