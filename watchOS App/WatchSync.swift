import Foundation
import WatchConnectivity
import SwiftBoost
import SwiftyJSON

class WatchSync: NSObject, WCSessionDelegate {
    
    static func configure() {
        debug("WatchSync: \(#function)")
        guard WCSession.isSupported() else { return }
        WCSession.default.delegate = WatchSync.shared
        WCSession.default.activate()
    }
    
    static func getApplicationContext() -> [String: Any] {
        return WCSession.default.receivedApplicationContext
    }
    
    // MARK: WCSessionDelegate
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        debug("WatchSync: \(#function) activationState: \(activationState.rawValue) error: \(String(describing: error?.localizedDescription))")
        
        // Trigger for update.
        debug("WatchSync: Send empty message for trigger update data.")
        session.sendMessage([:], replyHandler: nil)
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        debug("WatchSync: \(#function) applicationContext: \(applicationContext)")
        syncWithMainApp()
    }
    
    // MARK: - Private
    
    private func syncWithMainApp() {
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
    
    // MARK: - Singltone
    
    static let shared = WatchSync()
    private override init() {}
}

extension Notification.Name {
    
    static var applicationContextDidReload = Notification.Name("applicationContextDidReload")
}
