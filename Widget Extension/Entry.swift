import Foundation
import WidgetKit

struct Entry: TimelineEntry {
    
    let otpCode: String
    let issuer: String?
    let date: Date
    
    let configuration: SelectAccountIntent
}
