import Foundation
import UIKit

enum AppLanguage: String, CaseIterable {
    case russian
    case english
    case german
    
    var id: String { rawValue }
    
    var titleText: String {
        switch self {
        case .russian:
            return "Русский"
        case .english:
            return "English"
        case .german:
            return "Deutsch"
        }
        
    }
    
    var detailText: String {
        switch self {
        case .russian:
            return Texts.SettingsController.Languages.russian
        case .english:
            return Texts.SettingsController.Languages.english
        case .german:
            return Texts.SettingsController.Languages.german
        }
    }
    
    static func state() -> AppLanguage {
        let languageCode = Locale.current.languageCode
        switch languageCode {
        case "en":
            return .english
        case "ru":
            return .russian
        case "de":
            return .german
        case .none:
            return .english
        case .some(_):
            return .english
        }
    }
    
}
