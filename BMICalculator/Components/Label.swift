//
//  Label.swift
//  BMICalculator
//
//  Created by Matthew Travers on 6/7/24.
//

import UIKit

struct Label {
    
    /// Creates a UILabel with customizable parameters
    ///
    /// ** Params:
    ///     - text: label text
    ///     - font: label font
    ///     - backgroundColor: background color, clear by default
    ///     - textColor: text color, preset by default
    ///     - textAlignment: text alignment, center by default
    /// ** Returns:
    ///     - UILabel with specified properties
    static func build(text: String?, font: UIFont, backgroundColor: UIColor = .clear, textColor: UIColor = ThemeColor.text, textAlignment: NSTextAlignment = .center) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.backgroundColor = backgroundColor
        label.textColor = textColor
        label.textAlignment = textAlignment
        return label
    }
}
