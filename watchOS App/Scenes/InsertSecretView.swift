import SwiftUI

struct InsertSecretView: View {
    
    @State private var insertedText = ""
    @State private var saveEnabled = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        List {
            Section {
                TextField("Secret", text: $insertedText)
                    .autocorrectionDisabled()
                    .textCase(.lowercase)
                    .onChange(of: insertedText) { newValue in
                        self.insertedText = newValue.trim
                        if let url = URL(string: self.insertedText) {
                            self.saveEnabled = AccountModel.getByURL(url) != nil
                        } else {
                            self.saveEnabled = false
                        }
                    }
            } header: {
                VStack(alignment: .leading, spacing: 0) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: 8)
                    Text("Insert Code")
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: 0)
                }
            } footer: {
                VStack(spacing: 16) {
                    Text("Description about insert here. You must to insert secrent or any data of QR provided code.")
                    VStack(spacing: 6) {
                        Button(action: {
                            KeychainStorage.save(rawURLs: [self.insertedText], with: Constants.WatchKeychain.service)
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                Text("Add Code")
                            }
                            .fontWeight(.medium)
                        })
                        .disabled(!saveEnabled)
                        .buttonStyle(.borderedProminent)
                        .tint(.accentColor)
                    }
                }
            }
        }
    }
}
