import UIKit
import NativeUIKit
import SparrowKit

extension ScanController {
    
    @objc func swipeHandler(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            initialCenter = scanView.center
        case .changed:
            let translation = gesture.translation(in: view)
            
            if scanView.center.y > initialCenter.y - 51 {
                scanView.center = CGPoint(x: initialCenter.x,
                                          y: initialCenter.y + translation.y)
            } else {
                scanView.center = CGPoint(x: initialCenter.x,
                                          y: initialCenter.y - 51)
            }
            
            if scanView.center.y < initialCenter.y - 50 {
                view.backgroundColor = UIColor.black.alpha(0.6)
            } else {
                if (translation.y / initialCenter.y) < 0.6 {
                    view.backgroundColor = UIColor.black.alpha(0.6 - (translation.y / initialCenter.y))
                    if view.backgroundColor!.alpha > 0.6 {
                        view.backgroundColor = UIColor.black.alpha(0.6)
                    }
                } else {
                    if (translation.y / initialCenter.y) > 0.5 {
                        view.backgroundColor = UIColor.black.alpha(0.0)
                    } else {
                        view.backgroundColor = UIColor.black.alpha(0.6)
                    }
                    
                }
            }
            
        case .ended, .cancelled:
            
            if scanView.center.y > (initialCenter.y + 50) {
                close()
            } else {
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveEaseInOut]) {
                    self.viewDidLayoutSubviews()
                }
            }
            
        default:
            break
        }
    }
    
}
