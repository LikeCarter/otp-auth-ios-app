import XCTest
@testable import OTPSwift

final class OTPSwiftTests: XCTestCase {
    func testExample() throws {
        
        let secret = base32DecodeToData("B4WYRBQOLL5WJM6C")!
        
        let code = OTPSwift.generateOTP(secret: secret)
        
        print(code)
    }
}
