//
//  UIColor+Extension.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/14.
//

import UIKit

extension UIColor {
    static let grey1 = color(r: 142, g: 142, b: 147)
    static let grey2 = color(r: 174, g: 174, b: 178)
    static let grey3 = color(r: 199, g: 199, b: 204)
    static let grey4 = color(r: 209, g: 209, b: 214)
    static let grey5 = color(r: 229, g: 229, b: 234)
    static let grey6 = color(r: 242, g: 242, b: 247)
    
    static let backGround1 = UIColor.white
    static let backGround2 = color(r: 242, g: 242, b: 247)
    static let backGround3 = UIColor.black.withAlphaComponent(0.02)
    
    private static func color(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) -> UIColor {
        UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
}
