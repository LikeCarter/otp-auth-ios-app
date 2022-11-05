import SwiftUI
import SwiftyJSON
import OTP

class DataProvider: ObservableObject {
    
    @Published var accounts: [AccountModel] = []
    @Published var fromDate = Date()
    
    init() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(syncData), name: .applicationContextDidReload, object: nil)
        syncData()
        
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
    
    @objc func syncData() {
        let context = WatchSync.getApplicationContext()
        let json = JSON(context)
        print("current is \(json)")
        var newURLs: [URL] = []
        for value in json["accounts"].arrayValue {
            if let string = value.string, let url = URL(string: string) {
                newURLs.append(url)
            }
        }
        
        // 1. Clean old values if it now present already
        let storageURLs = KeychainStorage.getRawURLs()
        var urlsToDelete: [URL] = []
        for url in storageURLs {
            if !newURLs.contains(url) {
                urlsToDelete.append(url)
            }
        }
        KeychainStorage.remove(rawURLs: urlsToDelete.map({ $0.absoluteString }))
        
        // 2. Adding new data
        KeychainStorage.save(rawURLs: newURLs.map({ $0.absoluteString }))
        
        // 3. Update data in app
        self.accounts = KeychainStorage.getAccounts()
    }
}
