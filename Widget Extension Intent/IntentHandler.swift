import Intents

class IntentHandler: INExtension, SelectWebsiteIntentHandling {
    
    func defaultWebsite(for intent: SelectWebsiteIntent) -> Website? {
        guard let account = AppSettings.getAllFromKeychain().first else { return nil }
        return convertAccountToWebsite(account)
    }
    
    func provideWebsiteOptionsCollection(for intent: SelectWebsiteIntent, searchTerm: String?, with completion: @escaping (INObjectCollection<Website>?, Error?) -> Void) {
        let websites: [Website] = AppSettings.getAllFromKeychain().map { account in
            return convertAccountToWebsite(account)
        }
        let collection = INObjectCollection(items: websites)
        completion(collection, nil)
    }
    
    override func handler(for intent: INIntent) -> Any {
        return self
    }
    
    private func convertAccountToWebsite(_ account: AccountModel) -> Website {
        let website = Website(
            identifier: account.oneTimePassword,
            display: account.website + " (\(account.login))"
        )
        website.login = account.login
        website.website = account.website
        website.secret = account.oneTimePassword
        return website
    }
}
