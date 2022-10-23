import Foundation
import UIKit

enum AppLanguage: String, CaseIterable {
    
    case ru
    case en
    case de
    case fr
    case uk
    
    var id: String { rawValue }
    
    var titleText: String {
        switch self {
        case .ru:
            return "Русский"
        case .en:
            return "English"
        case .de:
            return "Deutsch"
        case .fr:
            return "Français"
        case .uk:
            return "Український"
        }
        
        
    }
    
    var detailText: String {
        switch self {
        case .ru:
            return Texts.SettingsController.Languages.russian
        case .en:
            return Texts.SettingsController.Languages.english
        case .de:
            return Texts.SettingsController.Languages.german
        case .fr:
            return Texts.SettingsController.Languages.french
        case .uk:
            return Texts.SettingsController.Languages.ukrainian
        }
    }
    
    static func state() -> AppLanguage {
        let languageCode = Locale.current.languageCode
        switch languageCode {
        case "en":
            return .en
        case "ru":
            return .ru
        case "de":
            return .de
        case "fr":
            return .fr
        case "uk":
            return .uk
        case .none:
            return .en
        case .some(_):
            return .en
        }
    }
    
}
