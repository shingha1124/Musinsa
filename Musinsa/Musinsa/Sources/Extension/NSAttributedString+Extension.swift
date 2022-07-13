//
//  NSAttributedString+Extension.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import UIKit

enum AttributedType {
    case font(_ font: UIFont)
    case foreground(color: UIColor)
    case background(color: UIColor)
    case underLined
    case strikethrough
    case paragraphStyle(_ style: NSMutableParagraphStyle)
}

extension NSAttributedString {
    static func appendAttributedString(_ strings: [NSAttributedString]) -> NSMutableAttributedString {
        let mutableAttributedString = NSMutableAttributedString()
        strings.forEach {
            mutableAttributedString.append($0)
        }
        return mutableAttributedString
    }
    
    private static func addAttribute(_ addAttribute: AttributedType) -> (NSAttributedString.Key, Any) {
        switch addAttribute {
        case .font(let font):
            return (.font, font)
        case .foreground(let color):
            return (.foregroundColor, color)
        case .background(let color):
            return (.backgroundColor, color)
        case .underLined:
            return (.underlineStyle, NSUnderlineStyle.single.rawValue)
        case .strikethrough:
            return (.strikethroughStyle, NSUnderlineStyle.single.rawValue)
        case .paragraphStyle(let style):
            return (.paragraphStyle, style)
        }
    }
    
    private static func addAttributes(_ addAttributes: [AttributedType]) -> [NSAttributedString.Key: Any] {
        var attributes = [NSAttributedString.Key: Any]()
        addAttributes.forEach { attribute in
            let (key, value) = addAttribute(attribute)
            attributes[key] = value
        }
        return attributes
    }
    
    static func stringToOption(_ string: String, attributes: [AttributedType] = []) -> NSAttributedString {
        let attributes = Self.addAttributes(attributes)
        return NSAttributedString(string: string, attributes: attributes)
    }
}
