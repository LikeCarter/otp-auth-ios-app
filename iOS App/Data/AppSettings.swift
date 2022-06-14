import Foundation
import KeychainAccess

enum AppSettings {
    
    static func saveToKeychain(id: String) {
        let keychain = Keychain(service: Constants.Keychain.service)
        keychain[id] = id
    }
    
    static func removeFromKeychain(id: String) {
        let keychain = Keychain(service: Constants.Keychain.service)
        keychain[id] = nil
    }
    
    static func getAllFromKeychain() -> [AccountModel] {
        let keychain = Keychain(service: Constants.Keychain.service)
        let keys = keychain.allKeys()
        var array: [AccountModel] = []
        if !keys.isEmpty {
            for key in keys {
                let token = keychain[key]
                let website = URL(string: token!)!.valueOf("issuer")
                let login = URL(string: token!)!.lastPathComponent
                let model = AccountModel(oneTimePassword: token!, website: website!, login: login)
                array.append(model)
            }
        }
        return array
    }
    
    static var isPasswordEnabled: Bool {
        get { UserDefaults.standard.bool(forKey: "isPasswordEnabled") }
        set { UserDefaults.standard.setValue(newValue, forKey: "isPasswordEnabled") }
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
