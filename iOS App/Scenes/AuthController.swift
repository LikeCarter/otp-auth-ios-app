import UIKit
import SparrowKit
import SPDiffable

class AuthController: SPDiffableTableController {
    
    public init() {
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        auth()
    }
    
    func auth() {
        let rootController = RootController()
        
        if Settings.isPasswordEnabled {
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
