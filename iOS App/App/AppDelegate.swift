import UIKit
import SparrowKit
import NativeUIKit

@main
class AppDelegate: SPAppWindowDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        makeKeyAndVisible(createViewControllerHandler: {
            return AppSettings.isPasswordEnabled ? AuthController() : RootController()
        }, tint: .systemBlue)
        
        AppearanceControlService.check()
        
        return true
    }
}
