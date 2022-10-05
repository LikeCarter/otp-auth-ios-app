import Foundation

class AccountModel: Equatable, Codable {
    
    static func == (lhs: AccountModel, rhs: AccountModel) -> Bool {
        return lhs.oneTimePassword == rhs.oneTimePassword
    }
    
    var oneTimePassword: String
    var website: String
    var login: String
    
    init(oneTimePassword: String, website: String, login: String) {
        self.oneTimePassword = oneTimePassword
        self.website = website
        self.login = login
    }
}
