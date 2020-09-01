//
//  NSMutableAttributedString+Coloring.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/09/01.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

//######Usage:
//let targetTxt = "TargetText"
//let baseTxt = "Something... \(targetTxt)"
//let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: baseTxt)
//attributedString.setColorForText(textForAttribute: targetTxt, withColor: .systemRed, isCaseSensitive: true)
extension NSMutableAttributedString {
    
    func setColorForText(textForAttribute: String, withColor color: UIColor, isCaseSensitive: Bool = false) {
        var range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        if isCaseSensitive {
            range = self.mutableString.range(of: textForAttribute)
        }
        
        // Swift 4.2 and above
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        
    }
}
