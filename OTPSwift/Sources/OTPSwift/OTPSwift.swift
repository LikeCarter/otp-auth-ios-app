import Foundation
import CryptoKit

public struct OTPSwift {
    
    public static func generateOTP(secret: Data, algorithm: OTPAlgorithm = .sha1, expirationTimeInSeconds: Int = 30, digits: Int = 6) -> String? {
        
        let secondsPast1970 = Int(floor(Date().timeIntervalSince1970))
        
        let counter = UInt64(floor(Double(secondsPast1970) / Double(expirationTimeInSeconds)))
        
        // HMAC message data from counter as big endian
        let counterMessage = counter.bigEndian.data
        
        // HMAC hash counter data with secret key
        var hmac = Data()
        
        switch algorithm {
        case .sha1:
            hmac = Data(HMAC<Insecure.SHA1>.authenticationCode(for: counterMessage, using: SymmetricKey(data: secret)))
        case .sha256:
            hmac = Data(HMAC<SHA256>.authenticationCode(for: counterMessage, using: SymmetricKey(data: secret)))
        case .sha512:
            hmac = Data(HMAC<SHA512>.authenticationCode(for: counterMessage, using: SymmetricKey(data: secret)))
        }
        
        
        // Get last 4 bits of hash as offset
        let offset = Int((hmac.last ?? 0x00) & 0x0f)
        
        // Get 4 bytes from the hash from [offset] to [offset + 3]
        let truncatedHMAC = Array(hmac[offset...offset + 3])
        
        // Convert byte array of the truncated hash to data
        let data =  Data(truncatedHMAC)
        
        // Convert data to UInt32
        var number = UInt32(strtoul(data.bytes.toHexString(), nil, 16))
        
        // Mask most significant bit
        number &= 0x7fffffff
        
        // Modulo number by 10^(digits)
        number = number % UInt32(pow(10, Float(digits)))
        
        // Convert int to string
        let strNum = String(number)
        
        // Return string if adding leading zeros is not required
        if strNum.count == digits {
            return strNum
        }
        
        // Add zeros to start of string if not present and return
        let prefixedZeros = String(repeatElement("0", count: (digits - strNum.count)))
        return (prefixedZeros + strNum)
    }
}

/// Hash algorithm to use for one time password generation
public enum OTPAlgorithm: Codable {
    case sha1
    case sha256
    case sha512
}

extension Array where Element == UInt8 {
    
    init(reserveCapacity: Int) {
        self = Array<Element>()
        self.reserveCapacity(reserveCapacity)
    }
    
    public init(hex: String) {
        self.init(reserveCapacity: hex.unicodeScalars.lazy.underestimatedCount)
        var buffer: UInt8?
        var skip = hex.hasPrefix("0x") ? 2 : 0
        for char in hex.unicodeScalars.lazy {
            guard skip == 0 else {
                skip -= 1
                continue
            }
            
            guard char.value >= 48 && char.value <= 102 else {
                removeAll()
                return
            }
            let v: UInt8
            let c: UInt8 = UInt8(char.value)
            
            switch c {
            case let c where c <= 57:
                v = c - 48
            case let c where c >= 65 && c <= 70:
                v = c - 55
            case let c where c >= 97:
                v = c - 87
            default:
                removeAll()
                return
            }
            
            if let b = buffer {
                append(b << 4 | v)
                buffer = nil
            } else {
                buffer = v
            }
        }
        
        if let b = buffer {
            append(b)
        }
    }
    
    public func toHexString() -> String {
        `lazy`.reduce(into: "") {
            var s = String($1, radix: 16)
            if s.count == 1 {
                s = "0" + s
            }
            $0 += s
        }
    }
}

extension Data {
    /// The data represented as a byte array
    public init(hex: String) {
        self.init(Array<UInt8>(hex: hex))
    }
    
    public var bytes: Array<UInt8> {
        return Array(self)
    }
}

extension UInt64 {
    /// Data from UInt64
    var data: Data {
        var int = self
        let intData = Data(bytes: &int, count: MemoryLayout.size(ofValue: self))
        return intData
    }
}


