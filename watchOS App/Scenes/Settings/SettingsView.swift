import SwiftUI

struct SettingsView: View {
    
    @AppStorage(Constants.ud_progress_show_key) var enabledProgress = true
    @AppStorage(Constants.ud_progress_show_profile) var enabledProfile = false
    
    @State private var showCleanKeychainAlert = false
    
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
            Section {
                Button {
                    showCleanKeychainAlert = true
                } label: {
                    SettingsRowView(title: "Clean all local Keychain", systemName: "trash.circle.fill", backgroundIconColor: .red)
                }
                .alert("Confirm", isPresented: $showCleanKeychainAlert, actions: {
                    Button("Clean All", role: .destructive, action: {
                        let urls = KeychainStorage.getRawURLs(with: Constants.WatchKeychain.service)
                        KeychainStorage.remove(rawURLs: urls, with: Constants.WatchKeychain.service)
                        showCleanKeychainAlert = false
                    })
                    Button("Cancel", role: .cancel, action: {
                        showCleanKeychainAlert = false
                    })
                }) {
                    Text("Comfirm deleting all accounts")
                }

            } header: {
                
            } footer: {
                Text("Will hide a rpogress on main screen.")
            }
        }
        .navigationTitle("Settings")
    }
}
