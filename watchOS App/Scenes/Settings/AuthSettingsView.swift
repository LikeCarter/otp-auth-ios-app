import SwiftUI

struct AuthSettingsView: View {
    
    @AppStorage(Constants.ud_show_otp_on_complications) var showInComplications = true
    @State private var selectedCodeVisibility = OTPCodeVisibility.all
    
    var body: some View {
        List {
            Section {
                Picker(selection: $selectedCodeVisibility) {
                    ForEach(OTPCodeVisibility.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                } label: {
                    Text("OTP Codes Visible")
                }
            } header: {
                
            } footer: {
                Text("Will hide a rpogress on main screen.")
            }
            Section {
                HStack {
                    Toggle("Show in Complications", isOn: $showInComplications)
                }
            } header: {
                
            } footer: {
                Text("Will hide a rpogress on main screen.")
            }
        }
        .navigationBarTitle("Authorisation")
    }
}

struct AuthSettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        AuthSettingsView()
            .previewDisplayName("Auth Settings")
    }
}
