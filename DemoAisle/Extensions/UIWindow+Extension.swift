//
//  UIWindow+Extension.swift
//  DemoAisle
//
//  Created by Rakshith on 27/08/22.
//

import UIKit

extension UIWindow {
    
    class func makeDefault() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        return window
    }

    class func makeForLoadingIndicator() -> UIWindow {
        let window = UIWindow.makeDefault()
        window.isHidden = true
        window.windowLevel = .loadingIndicator
     return window
    }
}

extension UIWindow.Level {
    static let loadingIndicator = Self.init(rawValue: UIWindow.Level.alert.rawValue + 1)
}

