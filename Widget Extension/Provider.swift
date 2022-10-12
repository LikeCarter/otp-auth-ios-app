import WidgetKit
import CryptoKit
import SwiftUI
import Intents
import SparrowKit
import OTP

struct Entry: TimelineEntry {
    
    let otpCode: String
    let website: String?
    let date: Date
    let configuration: SelectWebsiteIntent
}

struct Provider: IntentTimelineProvider {
    
    var dataHidden: Bool {
        return (UserDefaults(suiteName: "group.io.sparrowcode.apps.otp-auth")?.bool(forKey: "hideWidgetData") ?? false)
    }
    
    func placeholder(in context: Context) -> Entry {
        Entry(
            otpCode: defaultCode,
            website: "sparrowcode.io",
            date: Date(),
            configuration: SelectWebsiteIntent()
        )
    }
    
    func getSnapshot(for configuration: SelectWebsiteIntent, in context: Context, completion: @escaping (Entry) -> ()) {
        let otpCode = getCodeBySecret(secret: configuration.website?.secret ?? defaultCode, for: Date()) ?? defaultCode
        let entry = Entry(
            otpCode: defaultCode,
            website: configuration.website?.website,
            date: Date(),
            configuration: configuration
        )
        completion(entry)
    }
    
    func getTimeline(for configuration: SelectWebsiteIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [Entry] = []
        let currentDate = Date().start(of: .minute)
        for codeIndex in 0...60 {
            let offset = TimeInterval(30 * codeIndex)
            let date = currentDate.addingTimeInterval(offset)
            let otpCode = getCodeBySecret(secret: configuration.website?.secret ?? defaultCode, for: date) ?? defaultCode
            let entry = Entry(
                otpCode: dataHidden ? hidenCode : defaultCode,
                website: configuration.website?.website,
                date: date,
                configuration: configuration
            )
            entries.append(entry)
        }
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    private func getCodeBySecret(secret: String, for date: Date) -> String? {
        guard let token = URL(string: secret)?.valueOf("secret") else { return nil }
        guard let tokenBase32 = base32DecodeToData(token) else { return nil }
        guard let otp = OTPExtended.generateOTP(secret: tokenBase32, for: date) else { return nil }
        return otp.prefix(3) + " " + otp.suffix(3)
    }
    
    private var defaultCode: String {
        return "414 651"
    }
    
    private var hidenCode: String {
        return "••• •••"
    }
}

// Becouse must to have special date
public enum OTPExtended {
    
    public static func generateOTP(secret: Data, algorithm: OTPAlgorithm = .sha1, expirationTimeInSeconds: Int = 30, digits: Int = 6, for date: Date = Date()) -> String? {
        
        let secondsPast1970 = Int(floor(date.timeIntervalSince1970))
        
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

extension UInt64 {

    var data: Data {
        var int = self
        let intData = Data(bytes: &int, count: MemoryLayout.size(ofValue: self))
        return intData
    }
}
