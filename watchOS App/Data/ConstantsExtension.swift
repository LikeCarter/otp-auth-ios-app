import SwiftUI

extension Constants {
    
    static var ud_progress_show_key: String { "is_show_progress" }
    static var ud_show_profile: String { "is_show_profile" }
    static var ud_account_visible_id: String { "is_account_visible_id" }
    static var ud_show_otp_on_complications: String { "is_show_otp_on_complications" }
    
    enum WatchKeychain {
        
        static var service: String { "io.sparrowcode.apps.otp-auth.watch.keychain" }
    }
}
