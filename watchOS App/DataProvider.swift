import SwiftUI
import SwiftyJSON
import OTP

class DataProvider: ObservableObject {
    
    @Published var accounts: [AccountModel] = []
    @Published var fromDate = Date()
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: .applicationContextDidReload, object: nil)
        updateData()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            let startMinuteDate = Date().start(of: .minute)
            var passedSeconds = Date().timeIntervalSince1970 - startMinuteDate.timeIntervalSince1970
            if passedSeconds > 30 {
                passedSeconds -= 30
                let newFromDate = startMinuteDate.addingTimeInterval(30)
                if self.fromDate != newFromDate {
                    self.fromDate = newFromDate
                    self.updateData()
                }
            } else {
                let newFromDate = startMinuteDate
                if self.fromDate != newFromDate {
                    self.fromDate = newFromDate
                    self.updateData()
                }
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func updateData() {
        self.accounts = parseApplicationContext()
    }
    
    private func parseApplicationContext() -> [AccountModel] {
        let context = WatchSync.getApplicationContext()
        let json = JSON(context)
        print("current is \(json)")
        var accounts: [AccountModel] = []
        for value in json["accounts"].arrayValue {
            guard let secret = value["secret"].string else { continue }
            guard let login = value["login"].string else { continue }
            guard let website = value["website"].string else { continue }
            guard let secretData = base32DecodeToData(secret) else { continue }
            guard let otp = OTP.generateOTP(secret: secretData) else { continue }
            accounts.append(
                AccountModel(
                    oneTimePassword: otp,
                    website: website,
                    login: login
                )
            )
        }
        return accounts
    }
}
