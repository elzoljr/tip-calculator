//
//  Double+Extension.swift
//  tip-calculator
//
//  Created by Elzo Lourenço Júnior on 07/03/24.
//

import Foundation

extension Double {
    
    var currencyFormatted : String {
        var isWholeNumber: Bool {
            isZero ? true : !isNormal ? false:  self == rounded()
        }
        
        let formatter = NumberFormatter()
        
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .currency
        
        formatter.minimumFractionDigits = isWholeNumber ? 0 : 2
        return  formatter.string(for: self) ?? ""
    }
}
