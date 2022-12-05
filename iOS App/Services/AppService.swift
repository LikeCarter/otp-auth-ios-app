import UIKit

enum AppService {
        
    /**
     Get current root controller.
     */
    static var rootController: UIViewController? {
        return UIApplication.shared.windows.first?.rootViewController
    }
    
    /**
     Replace root controller.
     */
    static func set(rootController: UIViewController, animatable: Bool) {
        rootController.view.frame = UIScreen.main.bounds
        guard let window = UIApplication.shared.windows.first else { return }
        if animatable {
            UIView.transition(with: window, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                window.rootViewController = rootController
            }, completion: nil)
        } else {
            window.rootViewController = rootController
        }
    }
    
}
