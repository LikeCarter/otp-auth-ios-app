import SwiftUI

struct SettingsView: View {
    
    @AppStorage(Constants.ud_progress_show_key) var enabledProgress = true
    @AppStorage(Constants.ud_progress_show_profile) var enabledProfile = false
    
    var body: some View {
        List {
            Section {
                NavigationLink {
                    AuthSettingsView()
                } label: {
                    SettingsRowView(title: Texts.SettingsController.Password.cell, systemName: "lock.circle.fill", backgroundIconColor: .green)
                }
            } header: {
                
            } footer: {
                Text("Will hide a rpogress on main screen.")
            }
            Section {
                HStack {
                    Toggle("Show Progress", isOn: $enabledProgress)
                }
            } header: {
                
            } footer: {
                Text("Will hide a rpogress on main screen.")
            }
            Section {
                HStack {
                    Toggle("Show Progile", isOn: $enabledProfile)
                }
            } header: {
                
            } footer: {
                Text("Will hide a rpogress on main screen.")
            }
        }
        .navigationTitle("Settings")
    }
}
