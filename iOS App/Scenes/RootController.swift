import UIKit
import NativeUIKit

class RootController: NativeNavigationController {

    init() {
        super.init(nibName: nil, bundle: nil)
        viewControllers = [HomeController(style: .insetGrouped)]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
