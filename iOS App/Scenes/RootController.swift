import UIKit
import NativeUIKit

class RootController: NativeNavigationController {

    init() {
        super.init(rootViewController: HomeController(style: .insetGrouped))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
