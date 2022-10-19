import UIKit
import NativeUIKit
import SparrowKit
import SafeSFSymbols
import AVFoundation

class ScanView: SPView, AVCaptureMetadataOutputObjectsDelegate {
    
    // MARK: - View
    
    let closeButton = SPButton(type: .close, primaryAction: .none)
    
    let titleLabel = SPLabel().do {
        $0.font = UIFont.preferredFont(forTextStyle: .title1, weight: .bold)
        $0.textAlignment = .center
        $0.numberOfLines = .zero
        $0.text = Texts.ScanController.title
    }
    
    let subtitleLabel = SPLabel().do {
        $0.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .regular)
        $0.textAlignment = .center
        $0.numberOfLines = .zero
        $0.text = Texts.ScanController.description
    }
    
    let cameraPreview = SPView().do {
        $0.backgroundColor = .secondarySystemBackground
        $0.roundCorners(radius: 13)
    }
    
    let featureView = ScanControllerFeatureView(features: [
            ScanFeatureModel(
                icon: UIImage(.qrcode.viewfinder),
                title: Texts.ScanController.scan_feature_title,
                subtitle: Texts.ScanController.scan_feature_description
            ),
            ScanFeatureModel(
                icon: UIImage(.square.andArrowDown),
                title: Texts.ScanController.google_import_feature_title,
                subtitle: Texts.ScanController.google_import_feature_description
            )
        ]
    )
    
    let scrollView = SPScrollView().do {
        $0.showsVerticalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = true
        $0.roundCorners(radius: 43)
    }
    
    // MARK: - Init
    
    override func commonInit() {
        super.commonInit()
        backgroundColor = .secondarySystemGroupedBackground

        layoutMargins = .init(horizontal: 32, vertical: 32)
        addSubview(scrollView)
        scrollView.addSubviews([closeButton, titleLabel, subtitleLabel, cameraPreview, featureView])
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        
        closeButton.frame = .init(
            x: self.frame.width - 54,
            y: 24,
            width: 28, height: 28
        )
        
        titleLabel.layoutDynamicHeight(
            x: 0,
            y: 32,
            width: self.frame.width / 1.5
        )
        titleLabel.center.x = self.frame.width / 2
        
        subtitleLabel.layoutDynamicHeight(
            x: 0,
            y: titleLabel.frame.maxY + 6,
            width: self.frame.width / 1.5
        )
        subtitleLabel.center.x = self.frame.width / 2
        
        cameraPreview.frame = .init(
            x: layoutMargins.left,
            y: subtitleLabel.frame.maxY + 22,
            width: self.bounds.width - (layoutMargins.left * 2),
            height: 180
        )
        
        featureView.frame = .init(
            x: cameraPreview.frame.origin.x,
            y: cameraPreview.frame.maxY + 20,
            width: cameraPreview.frame.width,
            height: featureView.frame.height
        )
        featureView.sizeToFit()
        
        scrollView.frame = .init(
            x: 0,
            y: 0,
            width: self.frame.width,
            height: self.frame.height
        )
        scrollView.contentSize = .init(width: frame.width, height: featureView.frame.maxY)
        
        if let superview = self.superview {
            if superview.frame.width <= 400 {
                roundCorners(radius: 50)
            } else {
                roundCorners(radius: 43)
            }
        }
    }
    
    // MARK: - Methods
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        layoutSubviews()
        return .init(width: size.width, height: featureView.frame.maxY + 22)
    }
    
    internal static let supportedCodeTypes = [
        AVMetadataObject.ObjectType.aztec,
        AVMetadataObject.ObjectType.qr
    ]
    
}
