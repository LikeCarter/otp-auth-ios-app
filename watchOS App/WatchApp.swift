import SwiftUI
import SwiftBoost

@main
struct WatchApp: App {
    
    init() {
        Logger.configure(levels: Logger.Level.allCases, fileNameMode: .show)
        WatchSync.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
