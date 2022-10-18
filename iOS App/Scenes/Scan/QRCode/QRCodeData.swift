import Foundation
import UIKit

public enum QRCodeData {

    case url(URL)
    case text(String)
    
    var prefix: String {
        switch self {
        case .url(_):
            return Texts.ScanController.qr_detail
        case .text(_):
            return Texts.ScanController.qr_detail
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
