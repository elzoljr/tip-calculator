//
//  Double+Extension.swift
//  tip-calculator
//
//  Created by Elzo Lourenço Júnior on 05/03/24.
//

import Foundation

extension String {
    var doubleValue: Double? {
        Double(self)
    }
    
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }

    var removeWhitespace: String {
        return self.replace(string: " ", replacement: "")
    }
}
