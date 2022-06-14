import Foundation

extension StringProtocol  {
    var digits: [Int] { compactMap(\.wholeNumberValue) }
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}

extension Numeric where Self: LosslessStringConvertible {
    var digits: [Int] { string.digits }
}
