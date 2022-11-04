import SwiftUI

struct InsertSecretView: View {
    
    @State private var insertText = ""
    @State private var isValidSecret = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        List {
            Section {
                TextField("Secret", text: $insertText)
                    .onChange(of: insertText) { newValue in
                        // fix it later
                        self.isValidSecret = !newValue.isEmpty
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
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                Text("Add Code")
                            }
                            .fontWeight(.medium)
                        })
                        .disabled(!isValidSecret)
                        .buttonStyle(.borderedProminent)
                        .tint(.accentColor)
                    }
                }
            }
        }
    }
}
