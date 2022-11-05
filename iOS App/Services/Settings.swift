import UIKit
import WidgetKit

enum Settings {
    
    static var isPasswordEnabled: Bool {
        get { UserDefaults.standard.bool(forKey: "isPasswordEnabled") }
        set { UserDefaults.standard.setValue(newValue, forKey: "isPasswordEnabled") }
    }
    
    static var hideWidgetData: Bool {
        get {
            UserDefaults(suiteName: "group.io.sparrowcode.apps.otp-auth")?.bool(forKey: "hideWidgetData") ?? false
        }
        set {
            UserDefaults(suiteName: "group.io.sparrowcode.apps.otp-auth")?.setValue(newValue, forKey: "hideWidgetData")
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    
    /**Return 1 for enabled, 2 for no sound, 3 for during day*/
    static var isSoundsEnabled: String {
        get { UserDefaults.standard.string(forKey: "isSoundsEnabled") ?? "1"}
        set { UserDefaults.standard.setValue(newValue, forKey: "isSoundsEnabled") }
    }
    
    static var isAppearanceAutomatic: Bool {
        get { !UserDefaults.standard.bool(forKey: "isAppearanceAutomatic") }
        set { UserDefaults.standard.setValue(!newValue, forKey: "isAppearanceAutomatic") }
    }
    
    static var appColor: AppColor {
        get {
            let id = UserDefaults.standard.string(forKey: "app_tintColor") ?? .space
            return AppColor(rawValue: id) ?? .blue
        }
        set {
            UserDefaults.standard.setValue(newValue.id, forKey: "app_tintColor")
        }
    }
    
    static var appTheme: AppTheme {
        get {
            let id = UserDefaults.standard.string(forKey: "app_theme") ?? .space
            return AppTheme(rawValue: id) ?? .light
        }
        set {
            UserDefaults.standard.setValue(newValue.id, forKey: "app_theme")
        }
    }
}
