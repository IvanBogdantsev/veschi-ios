//
//  Fonts.swift
//  
//
//  Created by Vanya Bogdantsev on 20.08.2023.
//

import UIKit

extension UIFont {
    /// Returns a bolded version of `self`.
    var bolded: UIFont {
        return self.fontDescriptor.withSymbolicTraits(.traitBold)
            .map { UIFont(descriptor: $0, size: 0.0) } ?? self
    }
    
    /// Returns a version of `self` with the desired weight.
    func weighted(_ weight: UIFont.Weight) -> UIFont {
        let descriptor = self.fontDescriptor.addingAttributes([
            .traits: [UIFontDescriptor.TraitKey.weight: weight]
        ])
        return UIFont(descriptor: descriptor, size: 0.0)
    }
    
    /// Returns a italicized version of `self`.
    var italicized: UIFont {
        return self.fontDescriptor.withSymbolicTraits(.traitItalic)
            .map { UIFont(descriptor: $0, size: 0.0) } ?? self
    }
    
    /// Returns a bold and italized version of `self`
    var boldItalic: UIFont {
        return self.fontDescriptor.withSymbolicTraits([.traitBold, .traitItalic])
            .map { UIFont(descriptor: $0, size: 0.0) } ?? self
    }
    
    /// regular, 17pt font, 22pt leading, -24pt tracking
    static func PROJECT_NAME_body(size: CGFloat? = nil) -> UIFont {
        return .preferredFont(style: .body, size: size)
    }
    
    /// regular, 16pt font, 21pt leading, -20pt tracking
    static func PROJECT_NAME_callout(size: CGFloat? = nil) -> UIFont {
        return .preferredFont(style: .callout, size: size)
    }
    
    /// regular, 12pt font, 16pt leading, 0pt tracking
    static func PROJECT_NAME_caption1(size: CGFloat? = nil) -> UIFont {
        return .preferredFont(style: .caption1, size: size)
    }
    
    /// regular, 11pt font, 13pt leading, 6pt tracking
    static func PROJECT_NAME_caption2(size: CGFloat? = nil) -> UIFont {
        return .preferredFont(style: .caption2, size: size)
    }
    
    /// regular, 13pt font, 18pt leading, -6pt tracking
    static func PROJECT_NAME_footnote(size: CGFloat? = nil) -> UIFont {
        return .preferredFont(style: .footnote, size: size)
    }
    
    /// semi-bold, 17pt font, 22pt leading, -24pt tracking
    static func PROJECT_NAME_headline(size: CGFloat? = nil) -> UIFont {
        return .preferredFont(style: .headline, size: size)
    }
    
    /// regular, 15pt font, 20pt leading, -16pt tracking
    static func PROJECT_NAME_subhead(size: CGFloat? = nil) -> UIFont {
        return .preferredFont(style: .subheadline, size: size)
    }
    
    /// light, 28pt font, 34pt leading, 13pt tracking
    static func PROJECT_NAME_title1(size: CGFloat? = nil) -> UIFont {
        return .preferredFont(style: .title1, size: size)
    }
    
    /// regular, 22pt font, 28pt leading, 16pt tracking
    static func PROJECT_NAME_title2(size: CGFloat? = nil) -> UIFont {
        return .preferredFont(style: .title2, size: size)
    }
    
    /// regular, 20pt font, 24pt leading, 19pt tracking
    static func PROJECT_NAME_title3(size: CGFloat? = nil) -> UIFont {
        return .preferredFont(style: .title3, size: size)
    }
    
    static func preferredFont(style: UIFont.TextStyle, size: CGFloat? = nil) -> UIFont {
        let defaultSize: CGFloat
        switch style {
        case UIFont.TextStyle.body: defaultSize = 17
        case UIFont.TextStyle.callout: defaultSize = 16
        case UIFont.TextStyle.caption1: defaultSize = 12
        case UIFont.TextStyle.caption2: defaultSize = 11
        case UIFont.TextStyle.footnote: defaultSize = 13
        case UIFont.TextStyle.headline: defaultSize = 17
        case UIFont.TextStyle.subheadline: defaultSize = 15
        case UIFont.TextStyle.title1: defaultSize = 28
        case UIFont.TextStyle.title2: defaultSize = 22
        case UIFont.TextStyle.title3: defaultSize = 20
        default: defaultSize = 17
        }
        
        let font: UIFont
        if #available(iOS 13.0, *) {
            font = UIFont.preferredFont(
                forTextStyle: style,
                compatibleWith: .current
            )
        } else {
            font = UIFont.preferredFont(forTextStyle: style)
        }
        let descriptor = font.fontDescriptor
        return UIFont(
            descriptor: descriptor,
            size: ceil(font.pointSize / defaultSize * (size ?? defaultSize))
        )
    }
}
