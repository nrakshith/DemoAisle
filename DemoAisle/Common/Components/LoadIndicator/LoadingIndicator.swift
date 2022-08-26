import UIKit

final class LoadingIndicator {
    static let shared = LoadingIndicator()

    private var window: UIWindow?
    private let duration = 0.2
    
    private init() {}
    
    func show(_ text: String) {
        // Check if window already shown
        guard window == nil else {
            return
        }
        
        let vc = LoadingIndicatorViewController(dependencies: .init(text: text))
        
        let window = UIWindow.makeForLoadingIndicator()
        window.rootViewController = vc
        window.alpha = 0
        window.makeKeyAndVisible()
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [.beginFromCurrentState], animations: {
            window.alpha = 1
        })
        
        self.window = window
    }
    
    func hide() {
        guard let window = window else {
            return
        }
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [.beginFromCurrentState], animations: {
            window.alpha = 0
        }, completion: { [weak self] _ in
            self?.window = nil
        })
    }
}
