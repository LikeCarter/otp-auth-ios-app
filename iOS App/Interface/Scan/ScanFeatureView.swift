import UIKit
import NativeUIKit
import SparrowKit
import SafeSFSymbols

class ScanFeatureView: SPView {
    
    let iconView = SPImageView().do {
        $0.tintColor = .label
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(.clear)
    }
    
    let titleLabel = SPLabel().do {
        $0.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .bold)
        $0.textAlignment = .left
        $0.numberOfLines = .zero
        $0.text = "Empty"
        $0.textColor = .label
    }
    
    let subtitleLabel = SPLabel().do {
        $0.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .regular)
        $0.textAlignment = .left
        $0.numberOfLines = .zero
        $0.text = "Empty"
        $0.textColor = .secondaryLabel
    }
    
    init(model: ScanFeatureModel) {
        super.init(frame: .zero)
        self.iconView.image = model.icon.alwaysTemplate
        self.iconView.tintColor = .tint
        self.titleLabel.text = model.title
        self.subtitleLabel.text = model.subtitle
        addSubviews([iconView, titleLabel, subtitleLabel])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconView.frame = .init(
            x: 0,
            y: 0,
            width: 36,
            height: 36
        )
        let titleLabelFrameX = iconView.frame.maxX + 16
        titleLabel.layoutDynamicHeight(
            x: titleLabelFrameX,
            y: 0,
            width: self.frame.width - titleLabelFrameX
        )
        subtitleLabel.layoutDynamicHeight(
            x: titleLabelFrameX,
            y: titleLabel.frame.maxY + 1,
            width: self.frame.width - titleLabelFrameX
        )

    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        layoutSubviews()
        return .init(width: size.width, height: subtitleLabel.frame.maxY + 1)
    }
    
}
