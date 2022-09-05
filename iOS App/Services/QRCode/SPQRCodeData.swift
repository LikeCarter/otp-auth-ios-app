import Foundation
import UIKit

public enum QRCodeData {

    case url(URL)
    case text(String)
    
    var prefix: String {
        switch self {
        case .url(_):
            return "Texts.qr_code_data_url_prefix"
        case .text(_):
            return "Texts.qr_code_data_text_prefix"
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .url(_):
            return UIImage(.app.badge)
        case .text(_):
            return UIImage(.app.badge)
        }
    }
}
