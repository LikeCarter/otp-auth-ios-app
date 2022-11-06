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
                    Text(Texts.Watch.settings_accounts_visible_title)
                }
            } header: {
                
            } footer: {
                Text(Texts.Watch.settings_accounts_visible_footer)
            }
            Section {
                HStack {
                    Toggle(Texts.Watch.settings_accounts_show_in_complications_title, isOn: $showInComplications)
                }
            } header: {
                
            } footer: {
                Text(Texts.Watch.settings_accounts_show_in_complications_footer)
            }
        }
        .navigationBarTitle(Texts.SettingsController.Password.cell)
    }
}

struct AuthSettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        AuthSettingsView()
            .previewDisplayName("Auth Settings")
    }
}
