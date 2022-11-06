import SwiftUI
import OTP

class DataProvider: ObservableObject {
    
    @Published var syncedAccounts: [AccountModel] = []
    @Published var localAccounts: [AccountModel] = []
    @Published var fromDate = Date()
    
    init() {
        
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

    private func setAccountsToObservableProperties() {
        self.syncedAccounts = KeychainStorage.getAccounts(with: Constants.Keychain.service)
        self.localAccounts = KeychainStorage.getAccounts(with: Constants.WatchKeychain.service)
    }
}
