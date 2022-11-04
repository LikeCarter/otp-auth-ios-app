import SwiftUI

struct ContentView: View {
    
    @ObservedObject var dataProvider = DataProvider()
    
    @State private var showingAddCodeSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    if !dataProvider.accounts.isEmpty {
                        Section {
                            ForEach(dataProvider.accounts, id: \.self) { account in
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
