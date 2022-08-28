//
//  LoadIndicator.swift
//  DemoAisle
//
//  Created by Rakshith on 28/08/22.
//

import UIKit

class LoadIndicator {
    
    var spinner = UIActivityIndicatorView(style: .medium)
    var loadingView: UIView = UIView()
    
    func showActivityIndicator(view: UIView) {
        DispatchQueue.main.async {
            self.loadingView = UIView()
            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 60.0, height: 60.0)
            self.loadingView.center = view.center
            self.loadingView.backgroundColor = UIColor.gray
            self.loadingView.alpha = 0.7
            self.loadingView.clipsToBounds = true
            self.loadingView.layer.cornerRadius = 10

            self.spinner = UIActivityIndicatorView(style: .medium)
            self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
            self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)

            self.loadingView.addSubview(self.spinner)
            view.addSubview(self.loadingView)
            self.spinner.startAnimating()
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }
    
}
