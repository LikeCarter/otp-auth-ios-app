import Foundation
import KeychainAccess

enum AppSettings {
    
    static func saveToKeychain(id: String) {
        let keychain = Keychain(service: Constants.Keychain.service)
        keychain[id] = id
        NotificationCenter.default.post(name: .changedAccounts, object: nil)
    }
    
    static func removeFromKeychain(id: String) {
        let keychain = Keychain(service: Constants.Keychain.service)
        keychain[id] = nil
        NotificationCenter.default.post(name: .changedAccounts, object: nil)
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
}

extension Notification.Name {
    
    static var changedAccounts = Notification.Name("changedAccounts")
}
