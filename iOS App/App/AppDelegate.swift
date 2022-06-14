import UIKit
import SparrowKit
import NativeUIKit

@main
class AppDelegate: SPAppWindowDelegate {
    
    var orientationLock = UIInterfaceOrientationMask.all
        
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        makeKeyAndVisible(createViewControllerHandler: {
            let navigationViewController = NativeNavigationController.init(rootViewController: RootController(style: .insetGrouped))
            return navigationViewController
        }, tint: .systemBlue)
        
        AppearanceControlService.check()
        
        return true
    }
}
