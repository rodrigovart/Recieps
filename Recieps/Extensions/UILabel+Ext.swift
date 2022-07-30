//
//  UILabel+Ext.swift
//  Recieps
//
//  Created by Rodrigo Vart on 28/07/22.
//

import Foundation
import UIKit

extension UILabel {
    static func textLabel(size: CGFloat, textColor: UIColor = .white, numberOfLines: Int = 1) -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica Neue Medium Extended", size: size)
        label.textColor = textColor
        label.numberOfLines = numberOfLines
        return label
    }
}
