//
//  UIView+Extension.swift
//  BMICalculator
//
//  Created by Matthew Travers on 6/10/24.
//

import UIKit

extension UIView {
    
    /// Adds custom shadow to view put on homescreen
    ///
    /// ** Params:
    ///     - offset: the offset of the shadow
    ///     - color: color of shadow
    ///     - radius: radius of shadow edge
    ///     - opacity: opacity of the shadow
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.cornerRadius = radius
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor = backgroundCGColor
    }
    
    /// Rounds the edges of the view it's applied to
    ///
    /// ** Params:
    ///     - radius: how much to round the edges by
    func addCornerRadius(radius: CGFloat) {
        layer.masksToBounds = false
        layer.cornerRadius = radius
    }
}
