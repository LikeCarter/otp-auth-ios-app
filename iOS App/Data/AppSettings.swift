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
}
