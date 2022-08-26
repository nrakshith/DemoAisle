//
//  LoadIndicatorViewController.swift
//  DemoAisle
//
//  Created by Rakshith on 27/08/22.
//

import UIKit
import RxCocoa
import RxSwift

class LoadingIndicatorViewController: UIViewController {
    var loadedView: LoadingIndicatorView { view as! LoadingIndicatorView }
    
    struct Dependencies {
        let text: String
    }
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = LoadingIndicatorView()
        view.label.text = dependencies.text
        self.view = view
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIAccessibility.post(notification: .screenChanged, argument: self)
    }
}
