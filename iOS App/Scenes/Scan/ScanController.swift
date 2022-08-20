import UIKit
import NativeUIKit
import SparrowKit
import SafeSFSymbols

class ScanController: SPController {
    
    // MARK: - Views
    
    let scanView = ScanView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.alpha(0.6)
        view.addSubview(scanView)
        let closeTap = UITapGestureRecognizer(target: self, action: #selector(close))
        let emptyTap = UITapGestureRecognizer()
        view.addGestureRecognizer(closeTap)
        scanView.addGestureRecognizer(emptyTap) // Restrict closing by tap scanView
        scanView.closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    // MARK: Layout
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            
            scanView.frame = .init(
                x: 5,
                y: 0,
                width: view.frame.width < 400 ? view.frame.width - 10 : view.frame.width / 1.5,
                height: view.frame.width < 400 ? scanView.frame.height : view.frame.height - 25
            )
            
            if view.frame.width < 400 { scanView.sizeToFit() } else { scanView.center.x = view.frame.width / 2 }
            scanView.frame.origin.y = view.frame.width < 400 ? view.frame.height - scanView.frame.height - 5 : 20
        } else {
            
            scanView.frame = .init(
                x: 0,
                y: 0,
                width: view.readableWidth,
                height: scanView.frame.height
            )
            scanView.sizeToFit()
            scanView.center.x = view.frame.width / 2
            scanView.center.y = view.frame.height / 2
        }
    }
    
    // MARK: - Methods
    
    @objc func close() {
        self.dismissAnimated()
    }
    
}
