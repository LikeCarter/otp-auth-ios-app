import UIKit
import NativeUIKit
import SparrowKit
import SafeSFSymbols

class ScanView: SPView {
    #warning("Localise this all")
    // MARK: - Views
    
    let closeButton = SPButton(type: .close, primaryAction: .none)
    
    let titleLabel = SPLabel().do {
        $0.font = UIFont.preferredFont(forTextStyle: .title1, weight: .bold)
        $0.textAlignment = .center
        $0.numberOfLines = .zero
        $0.text = "Add Accessory"
    }
    
    let subtitleLabel = SPLabel().do {
        $0.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .regular)
        $0.textAlignment = .center
        $0.numberOfLines = .zero
        $0.text = "Scan code of hold iPhone near the accessory. More options…"
    }
    #warning("Make cameraView a true camera")
    let cameraView = SPView().do {
        $0.backgroundColor = .secondarySystemBackground
        $0.layer.cornerRadius = 11
    }
    
    let featureView = ScanControllerFeatureView(features: [
            ScanFeatureModel(
                icon: UIImage(.qrcode.viewfinder),
                title: "Scan a Setup Code",
                subtitle: "Look for a QR code on the accessory, packaging, or instructions and position it in the camera frame above."
            ),
            ScanFeatureModel(
                icon: UIImage(.qrcode.viewfinder),
                title: "Scan a Setup Code",
                subtitle: "Look for a QR code on the accessory, packaging, or instructions and position it in the camera frame above."
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
        backgroundColor = .systemBackground
        roundCorners(radius: 43)
        layoutMargins = .init(horizontal: 32, vertical: 32)
        addSubview(scrollView)
        scrollView.addSubviews([closeButton, titleLabel, subtitleLabel, cameraView, featureView])
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        
        closeButton.frame = .init(
            x: self.frame.width - 44,
            y: 20,
            width: 24, height: 24
        )
        
        titleLabel.layoutDynamicHeight(
            x: 0,
            y: 32,
            width: self.frame.width / 1.5
        )
        titleLabel.center.x = self.frame.width / 2
        
        subtitleLabel.layoutDynamicHeight(
            x: 0,
            y: titleLabel.frame.maxY + 8,
            width: self.frame.width / 1.5
        )
        subtitleLabel.center.x = self.frame.width / 2
        
        cameraView.frame = .init(
            x: layoutMargins.left,
            y: subtitleLabel.frame.maxY + 22,
            width: self.frame.width - (layoutMargins.left * 2),
            height: 180
        )
        
        featureView.frame = .init(
            x: cameraView.frame.origin.x,
            y: cameraView.frame.maxY + 20,
            width: cameraView.frame.width,
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
        
    }
    
    // MARK: - Methods
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        layoutSubviews()
        return .init(width: size.width, height: featureView.frame.maxY + 22)
    }
    
}
