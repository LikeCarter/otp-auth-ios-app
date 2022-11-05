import Foundation
import WatchConnectivity
import SwiftBoost

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
        NotificationCenter.default.post(name: .applicationContextDidReload)
    }
    
    // MARK: - Singltone
    
    static let shared = WatchSync()
    private override init() {}
}

extension Notification.Name {
    
    static var applicationContextDidReload = Notification.Name("applicationContextDidReload")
}
