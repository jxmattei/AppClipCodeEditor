//
//  UIColorExtension.swift
//  AppClipCodeEditorExample
//
//  Created by Jorge Mattei on 6/19/23.
//

import Foundation
import UIKit
import AppClipCodeEditor


extension AppClipCodeTheme {
    public var primaryColor: UIColor! {
        return UIColor(hex: self.primaryColorHex)!
    } 
    public var circleColor: UIColor! {
        return UIColor(hex: self.circleColorHex)!
    }
}


extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            var hexColor = String(hex[start...])
            if hexColor.count == 6 {
                hexColor += "ff"
            }
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
