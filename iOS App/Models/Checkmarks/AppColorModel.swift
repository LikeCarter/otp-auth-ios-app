import Foundation
import UIKit

enum AppColor: String, CaseIterable {
    
    case red
    case pink
    case orange
    case yellow
    case green
    case blue
    case purple
    case gray
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .red:
            return Texts.SettingsController.Appearance.red_color
        case .pink:
            return Texts.SettingsController.Appearance.pink_color
        case .orange:
            return Texts.SettingsController.Appearance.orange_color
        case .yellow:
            return Texts.SettingsController.Appearance.yellow_color
        case .green:
            return Texts.SettingsController.Appearance.green_color
        case .blue:
            return Texts.SettingsController.Appearance.blue_color
        case .purple:
            return Texts.SettingsController.Appearance.purple_color
        case .gray:
            return Texts.SettingsController.Appearance.gray_color
        }
    }
    
    var image: UIImage {
        switch self {
        case .red:
            return UIImage.init(color: .systemRed, size: .init(width: 30, height: 30))
        case .pink:
            return UIImage.init(color: .systemPink, size: .init(width: 30, height: 30))
        case .orange:
            return UIImage.init(color: .systemOrange, size: .init(width: 30, height: 30))
        case .yellow:
            return UIImage.init(color: .systemYellow, size: .init(width: 30, height: 30))
        case .green:
            return UIImage.init(color: .systemGreen, size: .init(width: 30, height: 30))
        case .blue:
            return UIImage.init(color: .systemBlue, size: .init(width: 30, height: 30))
        case .purple:
            return UIImage.init(color: .systemPurple, size: .init(width: 30, height: 30))
        case .gray:
            return UIImage.init(color: .systemGray, size: .init(width: 30, height: 30))
        }
    }
    
    var uiColor: UIColor {
        switch self {
        case .red:
            return .systemRed
        case .pink:
            return .systemPink
        case .orange:
            return .systemOrange
        case .yellow:
            return .systemYellow
        case .green:
            return .systemGreen
        case .blue:
            return .systemBlue
        case .purple:
            return .systemPurple
        case .gray:
            return .systemGray
        }
    }
}
