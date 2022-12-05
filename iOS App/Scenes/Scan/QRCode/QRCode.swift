import Foundation
import UIKit

public class QRCode {
    
    internal static func scanning(
        detect: ((QRCodeData?, ScanController)->QRCodeData?)? = nil,
        handled: ((QRCodeData, ScanController)->Void)?,
        on controller: UIViewController
    ) {
        let qrController = ScanController()
        if let detect = detect {
            qrController.detectQRCodeData = detect
        }
        qrController.handledQRCodeData = handled
        qrController.modalPresentationStyle = .overFullScreen
        qrController.modalTransitionStyle = .crossDissolve
        controller.present(qrController)
    }
}
