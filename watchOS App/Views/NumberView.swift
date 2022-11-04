import SwiftUI

struct NumberView: View {
    
    let number: String
    
    var body: some View {
        Text(number)
            .padding(.horizontal, 2)
            .overlay {
                Rectangle()
                    .foregroundColor(.secondary)
                    .opacity(0.16)
                    .cornerRadius(3)
            }
    }
}
