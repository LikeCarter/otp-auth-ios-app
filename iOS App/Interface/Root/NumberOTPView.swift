import SparrowKit
import UIKit

class NumberOTPView: SPView {
    
    // MARK: - Views
    
    var numberLabel = SPLabel().do {
        $0.font = .preferredFont(forTextStyle: .title1, weight: .semibold).monospaced
        $0.adjustsFontSizeToFitWidth = true
        $0.textColor = .label
        $0.textAlignment = .center
    }
    
    // MARK: - Init
    
    init(number: Int) {
        super.init()
        numberLabel.text = String(number)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setupUI() {
        self.backgroundColor = .tertiarySystemGroupedBackground
        self.layer.masksToBounds = true
        self.addSubview(numberLabel)
        self.layoutMargins = .init(horizontal: 2, vertical: 4)
        self.layer.cornerRadius = 10
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        numberLabel.sizeToFit()
        numberLabel.center.x = self.frame.width / 2
        numberLabel.center.y = self.frame.height / 2
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        numberLabel.sizeToFit()
        return .init(width: layoutMargins.left + layoutMargins.right + numberLabel.frame.width, height: layoutMargins.top + layoutMargins.bottom + numberLabel.frame.height)
    }
}
