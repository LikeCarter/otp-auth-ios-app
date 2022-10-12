import UIKit
import AVFAudio
import SparrowKit
import NativeUIKit

@main
class AppDelegate: SPAppWindowDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        makeKeyAndVisible(createViewControllerHandler: {
            return AppSettings.isPasswordEnabled ? AuthController() : RootController()
        }, tint: .systemBlue)
        
        AppearanceControlService.check()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.soloAmbient)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        } catch {}
        
        return true
    }
}
