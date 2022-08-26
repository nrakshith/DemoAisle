//
//  CancellationAlertController.swift
//  DemoAisle
//
//  Created by Rakshith on 27/08/22.
//

import UIKit
import RxSwift
import RxCocoa

class CancellationAlertController {
    
    var selectedCancel: ControlEvent<Void> { cancelRelay.asControlEvent() }
    private let cancelRelay = PublishRelay<Void>()
    
    var title: String?
    var message: String?
    var cancel: Action = Action(title: "Cancel", style: .cancel)
    var preferredAction: PreferredAction = .none
    
    func present(title: String? = nil, message: String? = nil, in viewController: UIViewController) {
        let resolvedTitle = title ?? self.title
        let resolvedMessage = message ?? self.message
        
        let ac = UIAlertController(title: resolvedTitle, message: resolvedMessage, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: self.cancel.title, style: self.cancel.style)
        { [weak self] _ in
            self?.cancelRelay.accept(())
        }
        
        ac.preferredAction = { [unowned self] in
            switch self.preferredAction {
            case .none:     return nil
            case .cancel:   return cancel
            }
        }()
        
        ac.addAction(cancel)
        
        viewController.present(ac, animated: true, completion: nil)
    }
}

extension CancellationAlertController {
    enum PreferredAction {
        case none
        case cancel
    }
    
    struct Action {
        let title: String
        let style: UIAlertAction.Style
    }
}
