import UIKit
import NativeUIKit
import SparrowKit
import SafeSFSymbols

class ScanControllerFeatureView: SPView {
    
    // MARK: - Views
    
    var features: [ScanFeatureModel] = []
    var featureViews: [ScanFeatureView] = []
    
    // MARK: - Init
    
    init(features: [ScanFeatureModel]) {
        super.init(frame: .zero)
        
        self.features = features
        setFeatures()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setFeatures() {

        for model in features {
            let featureView = ScanFeatureView(
                model: ScanFeatureModel(
                    icon: model.icon,
                    title: model.title,
                    subtitle: model.subtitle
                )
            )
            featureViews.append(featureView)
            addSubview(featureView)
        }
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var yPosition: CGFloat = 0
        for (_, view) in featureViews.enumerated() {
            view.frame = .init(
                x: 0,
                y: yPosition,
                width: frame.width,
                height: view.frame.height
            )
            view.sizeToFit()
            yPosition = yPosition + view.frame.height + 25
            view.layoutSubviews()
        }
        
    }
    
    // MARK: - Methods
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        layoutSubviews()
        return .init(width: size.width, height: featureViews[featureViews.count - 1].frame.maxY + 5)
    }
    
}
