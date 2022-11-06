import SwiftUI

enum OTPCodeVisibility: String, CaseIterable {
    
    case all
    case onlySync
    case onlyLocal
    
    var localized: String {
        switch self {
        case .all:
            return Texts.Watch.code_visible_all
        case .onlySync:
            return Texts.Watch.code_visible_only_sync
        case .onlyLocal:
            return Texts.Watch.code_visible_only_local
        }
    }
}

