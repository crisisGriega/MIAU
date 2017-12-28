//
//  MainTheme.swift
//  MIAU
//
//  Created by Gerardo on 28/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import UIKit


/* TODO: Refactor:
 Group TextStyle and ButtonStyle under the same Enum
 Change ColorPalette to ColorPalette
 Create a new ColorPalette: String Enum so we can ask the Theme about a color based on a String and it will return UIColor
 Rename so styles are not linked to a color directly
 */
enum TextStyle: String {
    case cellTitle;
    case cellSubtitle;
}

enum ColorPalette: Int, EnumColorable {
    case red = 0xe23636;
    case black = 0x000000;
    case gray = 0x504a4a;
    case blue = 0x518cca;
    case orange = 0xf78f3f;
    case white = 0xffffff;
}

enum ColorStyle: String {
    case primary;
    case secondary;
    case tertiary;
    case quaternary;
    case quinary;
    case sexary;
}

class MainTheme: Themeable {
    
    init() {
        UILabel.loadSwizzling();
    }
    
    //MARK: Themeable functions
    
    func apply(_ style: String, to label: UILabel) {
        guard let styleCase = TextStyle(rawValue: style) else {
            return;
        }
        
        switch styleCase {
            case .cellTitle:
                label.textColor = ColorPalette.white.colorValue();
            case .cellSubtitle:
                label.textColor = ColorPalette.white.colorValue();
        }
        
        if let font = self.textFont(for: style)  {
            label.font = font;
        }
    }
    
    func textFont(for style: String) -> UIFont? {
        guard let styleCase = TextStyle(rawValue: style) else {
            return nil;
        }
        
        switch styleCase {
            case .cellTitle:
                return self.boldMarvelFont(with: 22);
            case .cellSubtitle:
                return UIFont.systemFont(ofSize: 12);
        }
    }
    
    func attributedString(for style: String, with text: String) -> NSAttributedString? {
        
        let wholeTextRange = NSMakeRange(0, text.count);
        
        return attributedString(for: style, with: text, and: wholeTextRange)
    }
    
    func attributedString(for style: String, with text: String, and range: NSRange) -> NSAttributedString? {
        
        guard let styleCase = TextStyle(rawValue: style) else {
            return nil;
        }
        guard let font = self.textFont(for: style) else {
            return nil;
        }
        
        let paragraphStyle = NSMutableParagraphStyle();
        var uppercase = false;
        var textColor: UIColor?;
        
        switch styleCase {
            case .cellTitle:
                paragraphStyle.lineSpacing = 0;
                uppercase = true;
                textColor = ColorPalette.white.colorValue();
            
            case .cellSubtitle:
                paragraphStyle.lineSpacing = 0;
                uppercase = false;
                textColor = ColorPalette.white.colorValue();
        }
        
        let stringText = uppercase ? text.uppercased() : text;
        let attributedString = NSMutableAttributedString(string: stringText);
        
        attributedString.addAttribute(NSAttributedStringKey.font, value: font, range: range);
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: range);
        if let color = textColor {
            attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range);
        }
        
        return attributedString;
    }
    
    func color(for style: String) -> UIColor? {
        guard let colorStyle = ColorStyle(rawValue: style) else {
            return nil;
        }
        
        return self.colorPalette(for: colorStyle).colorValue();
    }
}


// MARK: Private
private extension MainTheme {
    private func regularMarvelFont(with size: CGFloat) -> UIFont? {
        return UIFont(name: "Marvel-Regular", size: size);
    }
    private func boldMarvelFont(with size: CGFloat) -> UIFont? {
        return UIFont(name: "Marvel-Bold", size: size);
    }
    
    private func image(with color: UIColor) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1);
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0);
        color.setFill();
        UIRectFill(rect);
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return image;
    }
    
    private func colorPalette(for colorStyle: ColorStyle) -> ColorPalette {
        switch colorStyle {
            case .primary:
                return .red;
            case .secondary:
                return .black;
            case .tertiary:
                return .gray;
            case .quaternary:
                return .blue;
            case .quinary:
                return .orange;
            case .sexary:
                return .white;
        }
    }
}
