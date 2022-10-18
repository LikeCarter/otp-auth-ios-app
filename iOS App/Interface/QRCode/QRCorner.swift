import Foundation
import CoreGraphics

struct QRCorner: Equatable {
    
    enum Kind: Int, CaseIterable {
        
        case topLeft = 0
        case bottomLeft = 1
        case bottomRight = 2
        case topRight = 3
        
        var verticalNeighbor: Kind {
            switch self {
            case .topLeft:
                return .bottomLeft
            case .bottomLeft:
                return .topLeft
            case .bottomRight:
                return .topRight
            case .topRight:
                return .bottomRight
            }
        }
        
        var horizontalNeighbor: Kind {
            switch self {
            case .topLeft:
                return .topRight
            case .bottomLeft:
                return .bottomRight
            case .bottomRight:
                return .bottomLeft
            case .topRight:
                return .topLeft
            }
        }
    }
    
    let kind: Kind
    let point: CGPoint
    
    let length: CGFloat
    let radius: CGFloat
    
    func startPoint(using corners: [QRCorner]) -> CGPoint? {
        guard let neighbor = corners.first(where: { self.kind.verticalNeighbor == $0.kind }) else {
            return nil
        }
        
        return pointOnLine(
            startPoint: point,
            endPoint: neighbor.point,
            distance: (length + radius)
        )
    }
    
    func preCurvePoint(using corners: [QRCorner]) -> CGPoint? {
        guard let neighbor = corners.first(where: { self.kind.verticalNeighbor == $0.kind }) else {
            return nil
        }
        
        return pointOnLine(
            startPoint: point,
            endPoint: neighbor.point,
            distance: radius
        )
    }
    
    func postCurvePoint(using corners: [QRCorner]) -> CGPoint? {
        guard let neighbor = corners.first(where: { self.kind.horizontalNeighbor == $0.kind }) else {
            return nil
        }
        
        return pointOnLine(
            startPoint: point,
            endPoint: neighbor.point,
            distance: radius
        )
    }
    
    func endPoint(using corners: [QRCorner]) -> CGPoint? {
        guard let neighbor = corners.first(where: { self.kind.horizontalNeighbor == $0.kind }) else {
            return nil
        }
        
        return pointOnLine(
            startPoint: point,
            endPoint: neighbor.point,
            distance: (length + radius)
        )
    }
    
    private func pointOnLine(startPoint: CGPoint, endPoint: CGPoint, distance: CGFloat = 0.0) -> CGPoint {
        let lDistance = endPoint.distance(from: startPoint)
        let vector = CGPoint(
            x: (endPoint.x - startPoint.x) / lDistance,
            y: (endPoint.y - startPoint.y) / lDistance
        )
        
        return .init(
            x: startPoint.x + distance * vector.x,
            y: startPoint.y + distance * vector.y
        )
    }
}
