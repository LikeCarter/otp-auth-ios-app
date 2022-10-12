import UIKit
import SparrowKit

class AuthController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        auth()
    }
    
    func auth() {
        let rootController = RootController()
        
        if AppSettings.isPasswordEnabled {
            AppLocalAuthentication.request(reason: Texts.Auth.logic_description) { (state) in
                if state {
                    AppService.set(rootController: rootController, animatable: false)
                } else {
                    let alertController = UIAlertController(
                        title: Texts.Auth.Alert.title,
                        message: Texts.Auth.Alert.description,
                        preferredStyle: .alert
                    )
                    alertController.addAction(title: Texts.Shared.try_again, style: .default) { alrt in
                        self.auth()
                    }
                    self.present(alertController)
                }
            }
        } else {
            AppService.set(rootController: rootController, animatable: false)
        }
    }
}
