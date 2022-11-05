import WidgetKit
import SwiftUI
import Intents
import OTP

struct OTPCodeWidget: Widget {
    
    let kind: String = "OTPCodeWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind,
            intent: SelectAccountIntent.self,
            provider: Provider()
        ) { entry in
            EntryView(entry: entry)
        }
        .configurationDisplayName(Texts.widget_title)
        .description(Texts.widget_description)
        .supportedFamilies(supportedFamilies)
    }
    
    private var supportedFamilies: [WidgetFamily] {
        #if os(iOS)
        return [.systemSmall, .systemMedium, .accessoryRectangular, .accessoryCircular, .accessoryInline]
        #endif
        #if os(watchOS)
        return [.accessoryRectangular, .accessoryCircular, .accessoryInline]
        #endif
    }
}

@main
struct SwiftWidgetsBundle: WidgetBundle {
    
    @WidgetBundleBuilder
    var body: some Widget {
        OTPCodeWidget()
    }
}
