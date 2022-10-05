import WidgetKit
import SwiftUI
import Intents
import OTP

struct OTPCodeWidget: Widget {
    
    let kind: String = "OTPCodeWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind,
            intent: SelectWebsiteIntent.self,
            provider: Provider()
        ) { entry in
            OTPWidgetEntryView(entry: entry)
        }
        .configurationDisplayName(Texts.widget_title)
        .description(Texts.widget_description)
        .supportedFamilies([.systemSmall, .accessoryRectangular])
    }
}

@main
struct SwiftWidgetsBundle: WidgetBundle {
    
    @WidgetBundleBuilder
    var body: some Widget {
        OTPCodeWidget()
    }
}
