import SwiftUI
import SwiftyJSON
import OTP

class DataProvider: ObservableObject {
    
    @Published var syncedAccounts: [AccountModel] = []
    @Published var localAccounts: [AccountModel] = []
    @Published var fromDate = Date()
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(syncWithMainApp), name: .applicationContextDidReload, object: nil)
        NotificationCenter.default.addObserver(forName: .changedAccounts, object: nil, queue: nil) { notification in
            self.setAccountsToObservableProperties()
        }
        
        setAccountsToObservableProperties()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            let startMinuteDate = Date().start(of: .minute)
            var passedSeconds = Date().timeIntervalSince1970 - startMinuteDate.timeIntervalSince1970
            if passedSeconds > 30 {
                passedSeconds -= 30
                let newFromDate = startMinuteDate.addingTimeInterval(30)
                if self.fromDate != newFromDate {
                    self.fromDate = newFromDate
                }
            } else {
                let newFromDate = startMinuteDate
                if self.fromDate != newFromDate {
                    self.fromDate = newFromDate
                }
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func syncWithMainApp() {
        let context = WatchSync.getApplicationContext()
        let json = JSON(context)
        print("current is \(json)")
        var newURLs: [String] = []
        for value in json["accounts"].arrayValue {
            if let string = value.string, let _ = URL(string: string) {
                newURLs.append(string)
            }
        }
        
        // 1. Clean old values if it now present already
        let storageURLs = KeychainStorage.getRawURLs()
        var urlsToDelete: [String] = []
        for url in storageURLs {
            if !newURLs.contains(url) {
                urlsToDelete.append(url)
            }
        }
        KeychainStorage.remove(rawURLs: urlsToDelete)
        
        // 2. Adding new data
        KeychainStorage.save(rawURLs: newURLs)
        
        // 3. Both action trigger notification and update observable properties.
    }
    
    private func setAccountsToObservableProperties() {
        self.syncedAccounts = KeychainStorage.getAccounts(with: Constants.Keychain.service)
        self.localAccounts = KeychainStorage.getAccounts(with: Constants.WatchKeychain.service)
    }
}
