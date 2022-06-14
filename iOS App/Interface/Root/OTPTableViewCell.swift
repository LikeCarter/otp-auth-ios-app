import UIKit
import SparrowKit
import OTPSwift

class OTPTableViewCell: SPTableViewCell {
    
    // MARK: - Views
    
    let loginLabel = SPLabel().do {
        $0.textColor = .systemGray
    }
    
    let websiteLabel = SPLabel().do {
        $0.textColor = .label
        $0.font = .systemFont(ofSize: 17, weight: .semibold)
    }
    
    var password: String?
    
    var codeView = CodeView()
    
    let copyButton = SPButton().do {
        $0.setImage(Images.copy, for: .normal)
        $0.isUserInteractionEnabled = false
    }
    
    // MARK: - Init
    
    override func commonInit() {
        super.commonInit()
        
        layoutMargins = .init(horizontal: 16, vertical: 16)
        
        contentView.addSubview(loginLabel)
        contentView.addSubview(websiteLabel)
        contentView.addSubview(codeView)
        contentView.addSubview(copyButton)
    }
    
    func updateCell(model: AccountModel) {
        loginLabel.text = model.login
        websiteLabel.text = model.website
        guard let url = URL(string: model.oneTimePassword) else { return }
        guard let token = url.valueOf("secret") else { return }
        guard let secret = base32DecodeToData(token) else { return }
        password = OTPSwift.generateOTP(secret: secret)
        codeView.setup(code: password ?? "XXXXXX")
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        websiteLabel.sizeToFit()
        loginLabel.sizeToFit()
        if websiteLabel.frame.width > layoutWidth / 2 && loginLabel.frame.width < layoutWidth / 2  {
            websiteLabel.layoutDynamicHeight(
                x: contentView.layoutMargins.left,
                y: contentView.layoutMargins.top,
                width: layoutWidth - 30 - loginLabel.frame.width
            )
        } else if websiteLabel.frame.width > layoutWidth / 2 {
            websiteLabel.layoutDynamicHeight(
                x: contentView.layoutMargins.left,
                y: contentView.layoutMargins.top,
                width: layoutWidth / 2
            )
        } else {
            websiteLabel.frame.origin.x = contentView.layoutMargins.left
            websiteLabel.frame.origin.y = contentView.layoutMargins.top
            websiteLabel.sizeToFit()
        }
        
        let loginLabelX = websiteLabel.frame.maxX + 10
        loginLabel.layoutDynamicHeight(
            x: loginLabelX,
            y: contentView.layoutMargins.top,
            width: layoutWidth - loginLabelX
        )
        
        codeView.frame = .init(
            x: contentView.layoutMargins.left,
            y: websiteLabel.frame.maxY + 10,
            width: codeView.frame.width,
            height: frame.height - websiteLabel.frame.maxY - 20
        )
        codeView.sizeToFit()
        
        copyButton.frame.origin.x = codeView.frame.maxX + 20
        copyButton.frame.origin.y = contentView.frame.maxY / 2
        copyButton.sizeToFit()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        layoutSubviews()
        return .init(width: contentView.frame.width, height: codeView.frame.maxY + contentView.layoutMargins.bottom)
    }
}
