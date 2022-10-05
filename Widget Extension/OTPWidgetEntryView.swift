import WidgetKit
import SwiftUI
import Intents
import OTP

struct OTPWidgetEntryView : View {
    
    @Environment(\.widgetFamily) var family: WidgetFamily
    
    var entry: Provider.Entry
    
    var body: some View {
        switch family {
        case .systemSmall, .systemMedium:
            ZStack {
                Rectangle()
                    .foregroundColor(.blue)
                ZStack {
                    VStack {
                        HStack(spacing: 2) {
                            Spacer()
                            Image(systemName: "shield.fill")
                            Text(Texts.short_app_name)
                        }
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .font(.caption)
                        Spacer()
                    }
                    if let data = entry.configuration.website {
                        VStack(alignment: .leading, spacing: 0) {
                            Spacer()
                            Text(data.website ?? "")
                                .foregroundColor(.black)
                                .opacity(0.8)
                                .fontWeight(.medium)
                                .font(.footnote)
                                .lineLimit(1)
                                .multilineTextAlignment(.leading)
                                .opacity(0.7)
                            Text(entry.otpCode)
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .font(.title)
                                .lineLimit(1)
                                .multilineTextAlignment(.leading)
                            ProgressView(
                                timerInterval: entry.date...entry.date.addingTimeInterval(30),
                                countsDown: true,
                                label: {},
                                currentValueLabel: {
                                    Text(timerInterval: entry.date...entry.date.addingTimeInterval(30), countsDown: true)
                                        .foregroundColor(.white)
                                        .fontWeight(.medium)
                                }
                            )
                            .tint(.white)
                            .progressViewStyle(.linear)
                        }
                    } else {
                        Text(Texts.no_any_accounts)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .font(.title)
                            .multilineTextAlignment(.leading)
                            .minimumScaleFactor(0.5)
                    }
                }
                .padding()
            }
        case .accessoryRectangular:
            ZStack {
                VStack(alignment: .center, spacing: 2) {
                    if let data = entry.configuration.website {
                        Text(data.website ?? "")
                            .foregroundColor(.secondary)
                            .opacity(0.8)
                            .fontWeight(.semibold)
                            .font(.body)
                            .lineLimit(1)
                            .opacity(0.7)
                            .minimumScaleFactor(0.5)
                        Text(entry.otpCode)
                            .foregroundColor(.primary)
                            .fontWeight(.semibold)
                            .font(.title2)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        ProgressView(
                            timerInterval: entry.date...entry.date.addingTimeInterval(30),
                            countsDown: true,
                            label: {},
                            currentValueLabel: {}
                        )
                        .padding(.horizontal)
                    } else {
                        Text(Texts.no_any_accounts)
                            .foregroundColor(.primary)
                            .fontWeight(.semibold)
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.5)
                    }
                }
            }
        default:
            Text(Texts.not_supported)
        }
    }
}
