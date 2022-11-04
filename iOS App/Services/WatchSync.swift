import UIKit
import WatchConnectivity

class WatchSync: NSObject, WCSessionDelegate {
    
    static func configure() {
        guard WCSession.isSupported() else { return }
        WCSession.default.delegate = shared
        WCSession.default.activate()
        
        NotificationCenter.default.addObserver(forName: .changedAccounts, object: nil, queue: nil) { notification in
            self.updateContext()
        }
    }
    
    static func updateContext() {
        
        guard WCSession.default.activationState == .activated else { return }
        
        var context: [String : Any] = [:]
        
        var decodedAccounts: [[String : Any]] = []
        for account in AppSettings.getAllFromKeychain() {
            
            guard let url = URL(string: account.oneTimePassword) else { continue }
            guard let secret = url.valueOf("secret") else { continue }
            
            let decodedAccount = [
                "secret" : secret,
                "login" : account.login,
                "website" : account.website,
            ]
            decodedAccounts.append(decodedAccount)
        }
        
        context["accounts"] = decodedAccounts
        
        print("WatchSync: \(#function)")
        
        do {
            try WCSession.default.updateApplicationContext(context)
        } catch {
            print("WatchSync: \(#function) error: \(error.localizedDescription) ")
        }
    }
    
    // MARK: WCSessionDelegate
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("WatchSync: \(#function) activationState: \(activationState.rawValue) error: \(String(describing: error?.localizedDescription)) ")
        WatchSync.updateContext()
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("\(#function): activationState = \(session.activationState.rawValue)")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        // Activate the new session after having switched to a new watch.
        // There is in the Apple's example.
        session.activate()
    }
    
    // MARK: - Singltone
    
    static let shared = WatchSync()
    private override init() {}
}
