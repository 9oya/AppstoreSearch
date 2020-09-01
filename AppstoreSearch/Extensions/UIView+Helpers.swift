//
//  UIView+Helpers.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/31.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

extension UIView {
    func addShadowView(offset:CGSize=CGSize(width: 0, height: 3), opacity:Float=0.3, radius:CGFloat=3, color:CGColor=UIColor.darkGray.cgColor, maskToBounds:Bool=false) {
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color
        self.layer.masksToBounds = maskToBounds
    }
    
    func showSpinner() {
        let spinner: UIActivityIndicatorView = {
            let indicator = UIActivityIndicatorView()
            // indicator.style = UIActivityIndicatorView.Style.large
            // indicator.color = .systemTeal
            indicator.layer.cornerRadius = 10.0
            indicator.startAnimating()
            indicator.tag = 475647
            indicator.translatesAutoresizingMaskIntoConstraints = false
            return indicator
        }()
        addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func hideSpinner() {
        if let spinner = viewWithTag(475647){
            spinner.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
}
