//
//  UIColor+Extensions.swift
//  CoreUIKit
//
//  Created by Anderson Oliveira on 03/09/25.
//

import UIKit

public extension UIColor {

    /// Retorna `true` se a cor for considerada escura
    var isDarkColor: Bool {
        var white: CGFloat = 0, alpha: CGFloat = 0
        getWhite(&white, alpha: &alpha)
        return white < 0.5
    }
}
