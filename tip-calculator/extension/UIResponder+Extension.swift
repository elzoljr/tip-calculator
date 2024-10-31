//
//  UIResponder+Extension.swift
//  tip-calculator
//
//  Created by Elzo Lourenço Júnior on 05/03/24.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
