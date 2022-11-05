import SwiftUI

struct ContentView: View {
    
    @ObservedObject var dataProvider = DataProvider()
    
    @State private var showingAddCodeSheet = false
    @State private var showDeleteAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    if !dataProvider.syncedAccounts.isEmpty {
                        Section {
                            ForEach(dataProvider.syncedAccounts, id: \.self) { account in
                                CodeView(
                                    account: account,
                                    fromDate: $dataProvider.fromDate
                                )
                            }
                        } header: {
                            
                        } footer: {
                            Text(Texts.HomeController.account_section_footer)
                        }
                    }
                    if !dataProvider.localAccounts.isEmpty {
                        Section {
                            ForEach(dataProvider.localAccounts, id: \.self) { account in
                                Button(action: {
                                    showDeleteAlert = true
                                }, label: {
                                    CodeView(
                                        account: account,
                                        fromDate: $dataProvider.fromDate
                                    )
                                })
                                .alert("Confirm", isPresented: $showDeleteAlert, presenting: account, actions: { account in
                                    Button("Delete", role: .destructive, action: {
                                        KeychainStorage.remove(rawURLs: [account.url.absoluteString], with: Constants.WatchKeychain.service)
                                        showDeleteAlert = false
                                    })
                                    Button("Cancel", role: .cancel, action: {
                                        showDeleteAlert = false
                                    })
                                }) { account in
                                    Text("Comfirm deleting \(account.login)")
                                }
                            }
                        } header: {
                            Text("Only at watch")
                        } footer: {
                            Text("Here local accounts.")
                        }
                    }
                    Section {
                        Button(action: {
                            showingAddCodeSheet.toggle()
                        }, label: {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                Text(Texts.HomeController.header_view_action)
                            }
                            .fontWeight(.medium)
                        })
                        .buttonStyle(.bordered)
                        .tint(.accentColor)
                    } header: {
                        
                    } footer: {
                        Text(Texts.HomeController.header_view_description)
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init())
                    Section {
                        NavigationLink(destination: {
                            SettingsView()
                        }, label: {
                            SettingsRowView(title: Texts.HomeController.settings_button, systemName: "gear.circle.fill", backgroundIconColor: .blue)
                        })
                    }
                }
            }
            .navigationTitle(Texts.HomeController.title)
        }
        .sheet(isPresented: $showingAddCodeSheet) {
            InsertSecretView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
            .previewDisplayName("Main")
        InsertSecretView()
            .previewDisplayName("Insert Secret")
        SettingsView()
            .previewDisplayName("Settings")
    }
}
