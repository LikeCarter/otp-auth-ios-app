import UIKit
import SparrowKit

enum AppTintColorService {
    
    static func set(color: AppColor) {
        AppSettings.appColor = color
        AppTintColorService.check()
    }
    
    static func check() {
        let id = AppSettings.appColor
        let sharedApp = UIApplication.shared
        sharedApp.delegate?.window??.tintColor = id.uiColor
    }
    
}
