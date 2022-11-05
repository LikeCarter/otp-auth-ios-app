import UIKit
import SparrowKit
import NativeUIKit

class CodeView: SPView {
    
    // MARK: - Views
    
    private var codeArray: [Int] = []
    private var numberOTPViews: [NumberOTPView] = []
    var isAdded = false
    
    // MARK: - Methods
    
    func setup(code: String) {
        codeArray = code.digits
        setNumbers()
    }
    
    func setNumbers() {
        if !isAdded {
            isAdded = true
            for number in codeArray {
                let numberOTPView = NumberOTPView(number: number)
                numberOTPViews.append(numberOTPView)
                addSubview(numberOTPView)
            }
            layoutSubviews()
        }
        
        let arrayOfViews = self.subviews as! [NumberOTPView]
        for view in arrayOfViews {
            view.numberLabel.text = "\(codeArray.removeFirst())"
        }
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var counter = 0
        
        var xPosition: CGFloat = 0
        var biggestWidth: CGFloat = 0
        numberOTPViews.forEach {
            $0.layoutSubviews()
            $0.sizeToFit()
            biggestWidth = $0.frame.width > biggestWidth ? $0.frame.width : biggestWidth
        }
        for (_, view) in numberOTPViews.enumerated() {
            counter += 1
            view.frame = .init(
                x: xPosition,
                y: 0,
                width: biggestWidth + 10,
                height: view.numberLabel.frame.height + 10
            )
            xPosition = counter == 3 ? view.frame.maxX + 14 : view.frame.maxX + 4
            view.layoutSubviews()
        }
        xPosition = 0
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        layoutSubviews()
        if numberOTPViews.isEmpty {
            return .init(width: 0, height: 0)
        } else {
            let lastCell = numberOTPViews.last!
            return .init(width: lastCell.frame.maxX, height: lastCell.frame.maxY)
        }
        
    }
}
