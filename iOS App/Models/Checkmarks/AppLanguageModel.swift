import Foundation
import UIKit

enum AppLanguage: String, CaseIterable {
    case russian
    case english
    
    var id: String { rawValue }
    
    var titleText: String {
        switch self {
        case .russian:
            return "Русский"
        case .english:
            return "English"
        }
        
    }
    
    var detailText: String {
        switch self {
        case .russian:
            return Texts.SettingsController.Languages.russian
        case .english:
            return Texts.SettingsController.Languages.english
        }
    }
    
    static func state() -> AppLanguage {
        let languageCode = Locale.current.languageCode
        switch languageCode {
        case "en":
            return .english
        case "ru":
            return .russian
        case .none:
            return .english
        case .some(_):
            return .english
        }
    }
    
}
