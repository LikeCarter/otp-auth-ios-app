import UIKit
import SparrowKit

enum AppTintColorService {
    
    static func set(color: AppColor) {
        Settings.appColor = color
        AppTintColorService.check()
    }
    
    static func check() {
        let id = Settings.appColor
        let sharedApp = UIApplication.shared
        sharedApp.delegate?.window??.tintColor = id.uiColor
    }
    
}
