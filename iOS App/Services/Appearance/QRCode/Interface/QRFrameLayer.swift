import UIKit

class QRFrameLayer: CAShapeLayer {
    
    private let cLength: CGFloat
    private let cRadius: CGFloat
    
    // MARK: - Init
    
    init(
        length: CGFloat = 16.0,
        radius: CGFloat = 16.0,
        lineWidth: CGFloat = 5.0,
        lineColor: UIColor = .systemYellow
    ) {
        self.cLength = length
        self.cRadius = radius
        
        super.init()
        
        self.strokeColor = lineColor.cgColor
        self.fillColor = UIColor.clear.cgColor
        
        self.lineWidth = lineWidth
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func action(forKey event: String) -> CAAction? {
        if event == "path" {
            let animation: CABasicAnimation = .init(keyPath: event)
            
            animation.duration = 0.3
            animation.timingFunction = CATransaction.animationTimingFunction()
            
            return animation
        }
        
        return super.action(forKey: event)
    }
    
    // MARK: - Actions
    
    func update(using points: [CGPoint]) {
        let corners = buildCorners(for: points)
        
        let framePath: UIBezierPath = .init()
        
        for corner in corners {
            guard let cStartPoint = corner.startPoint(using: corners),
                  let cPreCurvePoint = corner.preCurvePoint(using: corners),
                  let cPostCurvePoint = corner.postCurvePoint(using: corners),
                  let cEndPoint = corner.endPoint(using: corners)
            else { return }
            
            framePath.move(to: cStartPoint)
            framePath.addLine(to: cPreCurvePoint)
            framePath.addQuadCurve(to: cPostCurvePoint, controlPoint: corner.point)
            framePath.addLine(to: cEndPoint)
        }
        
        path = framePath.cgPath
    }
    
    func dissapear() {
        path = nil
    }
    
    private func buildCorners(for points: [CGPoint]) -> [QRCorner] {
        var corners: [QRCorner] = .init()
        
        for corner in QRCorner.Kind.allCases {
            corners.append(
                .init(
                    kind: corner,
                    point: points[corner.rawValue],
                    length: cLength,
                    radius: cRadius
                )
            )
        }
        
        return corners
    }
}
