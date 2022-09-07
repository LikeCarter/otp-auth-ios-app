import UIKit
import SparrowKit

class QRDetailButton: SPDimmedButton {
    
    // MARK: - Init
    
    override func commonInit() {
        super.commonInit()
        titleLabel?.lineBreakMode = .byTruncatingTail
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote, weight: .regular)
        titleImageInset = 4
        contentEdgeInsets = .init(horizontal: 10, vertical: 6)
        applyDefaultAppearance(with: .init(content: .black, background: .systemYellow))
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundMinimumSide()
    }
}
