import Foundation
import KeychainAccess

enum KeychainStorage {
    
    static func save(rawURLs: [String]) {
        if rawURLs.isEmpty { return }
        let keychain = Keychain(service: Constants.Keychain.service)
        for url in rawURLs {
            keychain[url] = url
        }
        NotificationCenter.default.post(name: .changedAccounts, object: nil)
    }
    
    static func remove(rawURLs: [String]) {
        if rawURLs.isEmpty { return }
        let keychain = Keychain(service: Constants.Keychain.service)
        for url in rawURLs {
            keychain[url] = nil
        }
        NotificationCenter.default.post(name: .changedAccounts, object: nil)
    }
    
    static func getRawURLs() -> [URL] {
        let keychain = Keychain(service: Constants.Keychain.service)
        var values: [URL] = []
        for key in keychain.allKeys() {
            guard let value = keychain[key] else { continue }
            if let url = URL(string: value) {
                values.append(url)
            }
        }
        return values
    }
    
    static func getAccounts() -> [AccountModel] {
        let keychain = Keychain(service: Constants.Keychain.service)
        let keys = keychain.allKeys()
        var array: [AccountModel] = []
        for key in keys {
            guard let token = keychain[key] else { continue }
            guard let login = URL(string: token)?.lastPathComponent else { continue }
            guard let issuer = URL(string: token)?.valueOf("issuer") else { continue }
            guard let secret = URL(string: token)?.valueOf("secret") else { continue }
            let model = AccountModel(login: login, secret: secret, issuer: issuer)
            array.append(model)
        }
        return array
    }
}

extension Notification.Name {
    
    static var changedAccounts = Notification.Name("changedAccounts")
}
