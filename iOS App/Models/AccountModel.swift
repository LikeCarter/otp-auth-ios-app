import Foundation
import OTP

class AccountModel: NSObject, Codable {
    
    static func == (lhs: AccountModel, rhs: AccountModel) -> Bool {
        return lhs.url == rhs.url
    }
    
    var login: String
    var secret: String
    var issuer: String
    
    init(login: String, secret: String, issuer: String) {
        self.login = login
        self.secret = secret
        self.issuer = issuer
    }
    
    var url: URL {
        let string = "otpauth://totp/\(login)?secret=\(secret)&issuer=\(issuer)"
        return URL(string: string)!
    }
    
    func getCode(for date: Date) -> String? {
        guard let decodedSecret = base32DecodeToData(secret) else { return nil }
        return OTP.generateOTP(secret: decodedSecret)
    }
}
