import UIKit
import AVFAudio
import SparrowKit
import NativeUIKit
import Firebase

@main
class AppDelegate: SPAppWindowDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        makeKeyAndVisible(createViewControllerHandler: {
            return Settings.isPasswordEnabled ? AuthController() : RootController()
        }, tint: .systemBlue)
        
        AppearanceControlService.check()
        WatchSync.configure()
        
        return true
    }
}
