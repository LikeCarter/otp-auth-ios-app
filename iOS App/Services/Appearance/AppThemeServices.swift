import UIKit
import SparrowKit

enum AppThemeService {
    
    static func set(style: AppTheme) {
        Settings.appTheme = style
        AppThemeService.check()
    }
    
    static func check() {
        let id = Settings.appTheme
        let sharedApp = UIApplication.shared
        switch id {
        case AppTheme.automatic:
            sharedApp.delegate?.window??.overrideUserInterfaceStyle = .unspecified
            
        case AppTheme.light:
            sharedApp.delegate?.window??.overrideUserInterfaceStyle = .light
            
        case AppTheme.dark:
            sharedApp.delegate?.window??.overrideUserInterfaceStyle = .dark
            
        }
    }
}
