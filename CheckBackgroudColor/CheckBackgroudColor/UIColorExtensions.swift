//
//  UIColorExtensions.swift
//  CheckBackgroudColor
//
//  Created by Kostas Filios on 5/1/20.
//  Copyright © 2020 Kostas Filios. All rights reserved.
//

import UIKit

extension UIColor {
    func inverse () -> UIColor {
        var r:CGFloat = 0.0; var g:CGFloat = 0.0; var b:CGFloat = 0.0; var a:CGFloat = 0.0;
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: 1.0-r, green: 1.0 - g, blue: 1.0 - b, alpha: a)
        }
        return .black // Return a default colour
    }
}
