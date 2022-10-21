import UIKit
import NativeUIKit
import SparrowKit
import SafeSFSymbols
import AVKit

class ScanController: SPController, UIGestureRecognizerDelegate {
    
    // MARK: - Views
    
    open var detectQRCodeData: ((QRCodeData, ScanController)->QRCodeData?) = { data, _ in return data }
    open var handledQRCodeData: ((QRCodeData, ScanController)->Void?)? = nil
    internal var qrCodeData: QRCodeData? { didSet { updateInterface() }}
    internal var updateTimer: Timer?
    internal let frameLayer = QRFrameLayer()
    internal lazy var captureSession: AVCaptureSession = makeCaptureSession()
    internal let detailView = QRDetailButton()
    let scanView = ScanView()
    lazy var cameraView = makeVideoPreviewLayer()
    
    lazy var panGesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(swipeHandler(_:)))
        gesture.delegate = self
        gesture.cancelsTouchesInView = false
        return gesture
    }()
    
    private var initialCenter: CGPoint = .zero
    
    private var presented: Bool = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.alpha(0)
        view.addSubview(scanView)
        
        let closeTap = UITapGestureRecognizer(target: self, action: #selector(close))
        let emptyTap = UITapGestureRecognizer()
        view.addGestureRecognizer(closeTap)
        scanView.addGestureRecognizer(emptyTap) // Restrict closing by tap scanView
        scanView.closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        scanView.addGestureRecognizer(panGesture)
        
        scanView.layer.masksToBounds = true
        scanView.cameraPreview.masksToBounds = true
        cameraView = makeVideoPreviewLayer()
        
        scanView.cameraPreview.layer.addSublayer(cameraView)
        scanView.cameraPreview.layer.addSublayer(frameLayer)
        scanView.cameraPreview.addSubview(detailView)
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
        
        updateInterface()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if presented {
            
        } else {
            self.presented = true
            UIView.animate(withDuration: 0.42, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0) {
                self.viewDidLayoutSubviews()
            }
            UIView.animate(withDuration: 0.36, delay: 0, options: .curveEaseInOut) {
                self.view.backgroundColor = .black.alpha(0.6)
            }
        }
        
    }
    
    // MARK: Layout
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            
            scanView.frame = .init(
                x: 5,
                y: 0,
                width: view.frame.width < 450 ? view.frame.width - 10 : view.frame.width / 1.5,
                height: view.frame.width < 450 ? scanView.frame.height : view.frame.height - 25
            )
            
            if view.frame.width < 450 { scanView.sizeToFit() } else { scanView.center.x = view.frame.width / 2 }
            scanView.frame.origin.y = view.frame.width < 450 ? view.frame.height - scanView.frame.height - 5 : 20
        } else {
            
            scanView.frame = .init(
                x: 0,
                y: 0,
                width: min(view.readableWidth, 420),
                height: scanView.frame.height
            )
            scanView.sizeToFit()
            scanView.center.x = view.frame.width / 2
            scanView.center.y = view.frame.height / 2
        }
        
        cameraView.frame.size = scanView.cameraPreview.frame.size
        
        if !presented {
            scanView.frame.origin.y = self.view.frame.height + 40
        }
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let orientation = UIDevice.current.orientation
        
        switch (orientation) {
        case .portrait:
            cameraView.connection!.videoOrientation = .portrait
        case .landscapeLeft:
            cameraView.connection!.videoOrientation = .landscapeRight
        case .landscapeRight:
            cameraView.connection!.videoOrientation = .landscapeLeft
        default:
            cameraView.connection!.videoOrientation = .portrait
        }
        
        viewDidLayoutSubviews()
        
    }
    #warning("Fix animations, refractor")
    @objc func swipeHandler(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            initialCenter = scanView.center
        case .changed:
            let translation = gesture.translation(in: view)
            scanView.center = CGPoint(x: initialCenter.x,
                                      y: initialCenter.y + translation.y)
            
            if (translation.y / initialCenter.y) < 0.6 {
                view.backgroundColor = UIColor.black.alpha(0.6 - (translation.y / initialCenter.y))
                if view.backgroundColor!.alpha > 0.6 {
                    view.backgroundColor = UIColor.black.alpha(0.6)
                }
            } else {
                view.backgroundColor = UIColor.black.alpha(0.6)
            }
            
        case .ended,
                .cancelled:
            
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
