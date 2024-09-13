//
//  ThemeFont.swift
//  BMICalculator
//
//  Created by Matthew Travers on 6/7/24.
//

import Foundation
import UIKit

struct ThemeFont {
    
    /// Custom font - Regular
    ///
    /// ** Params:
    ///     - size: size of text to be returned
    /// ** Returns:
    ///     - UIFont: finished font with size and level of boldness
    static func regular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    /// Custom font - Bold
    ///
    /// ** Params:
    ///     - size: size of text to be returned
    /// ** Returns:
    ///     - UIFont: finished font with size and level of boldness
    static func bold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Bold", size: size) ?? .systemFont(ofSize: size)
    }
    
    /// Custom font - Semi-Bold
    ///
    /// ** Params:
    ///     - size: size of text to be returned
    /// ** Returns:
    ///     - UIFont: finished font with size and level of boldness
    static func demibold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-DemiBold", size: size) ?? .systemFont(ofSize: size)
    }
}
