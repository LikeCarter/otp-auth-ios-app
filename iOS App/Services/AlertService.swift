import UIKit
import SparrowKit
import SPAlert
import SPIndicator

enum AlertService {
    
    static func copied() {
        let indicatorView = SPIndicatorView(title: Texts.Shared.copied, preset: .done)
        indicatorView.present(duration: 3)
        SoundsService.play(sound: .success)
    }
    
    static func code_added() {
        SPAlert.present(
            title: Texts.Shared.added,
            message: Texts.Alerts.code_added,
            preset: .done,
            completion: nil
        )
        SoundsService.play(sound: .success)
    }
    
    static func code_deleted() {
        SPAlert.present(
            title: Texts.Shared.deleted,
            message: Texts.Alerts.code_deleted,
            preset: .done,
            completion: nil
        )
        SoundsService.play(sound: .delete)
    }
    
    static func alertNoToken(controller: UIViewController) {
        let alert = UIAlertController(
            title: Texts.Shared.error,
            message: Texts.Alerts.no_token,
            preferredStyle: .alert
        )
        let action = UIAlertAction(
            title: Texts.Shared.OK,
            style: .default,
            handler: nil
        )
        alert.addAction(action)
        controller.present(alert, animated: true, completion: nil)
        SoundsService.play(sound: .error)
    }
    
    static func alertTheSameCode(controller: UIViewController) {
        let alert = UIAlertController(
            title: Texts.Shared.error,
            message: Texts.Alerts.token_exists,
            preferredStyle: .alert
        )
        let action = UIAlertAction(
            title: Texts.Shared.OK,
            style: .default,
            handler: nil
        )
        alert.addAction(action)
        controller.present(alert, animated: true, completion: nil)
        SoundsService.play(sound: .error)
    }
    
    static func alertIncorrectURL(controller: UIViewController) {
        let alert = UIAlertController(
            title: Texts.Shared.error,
            message: Texts.Alerts.incorrect_url,
            preferredStyle: .alert)
        let actionOK = UIAlertAction(
            title: Texts.Shared.OK,
            style: .default,
            handler: nil
        )
        alert.addAction(actionOK)
        controller.present(alert, animated: true, completion: nil)
        SoundsService.play(sound: .error)
    }
    
    static func email_error() {
        SPAlert.present(message: Texts.Alerts.email_error, haptic: .error)
        SoundsService.play(sound: .error)
    }
    
}
