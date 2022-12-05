import Foundation
import KeychainAccess

enum KeychainStorage {
    
    static func save(rawURLs: [String], with keychainID: String = Constants.Keychain.service) {
        if rawURLs.isEmpty { return }
        let keychain = Keychain(service: keychainID)
        for urlstr in rawURLs {
            let str = urlstr.replacingOccurrences(of: "%40", with: "@")
            if let url = URL(string: str) {
                keychain[url.absoluteString] = url.absoluteString
            }
            
        }
        NotificationCenter.default.post(name: .changedAccounts, object: nil)
    }
    
    static func remove(rawURLs: [String], with keychainID: String = Constants.Keychain.service) {
        if rawURLs.isEmpty { return }
        let keychain = Keychain(service: keychainID)
        for urlstr in rawURLs {
            let str = urlstr.replacingOccurrences(of: "%40", with: "@")
            if let url = URL(string: str) {
                keychain[url.absoluteString] = nil
            }
        }
        NotificationCenter.default.post(name: .changedAccounts, object: nil)
    }
    
    static func getRawURLs(with keychainID: String = Constants.Keychain.service) -> [String] {
        let keychain = Keychain(service: keychainID)
        var values: [String] = []
        for key in keychain.allKeys() {
            guard let value = keychain[key] else { continue }
            values.append(value)
        }
        return values
    }
    
    static func getAccounts(with keychainID: String = Constants.Keychain.service) -> [AccountModel] {
        var array: [AccountModel] = []
        let urls = getRawURLs(with: keychainID)
        for string in urls {
            guard let url = URL(string: string) else { continue }
            let login = url.lastPathComponent
            guard let issuer = url.valueOf("issuer") else { continue }
            guard let secret = url.valueOf("secret") else { continue }
            let model = AccountModel(login: login, secret: secret, issuer: issuer)
            array.append(model)
        }
        return array
    }
}

extension Notification.Name {
    
    static var changedAccounts = Notification.Name("changedAccounts")
}
