import SwiftUI

struct SettingsRowView: View {
    
    let title: String
    let systemName: String
    let backgroundIconColor: Color
    
    var body: some View {
        HStack {
            Image(systemName: systemName)
                .symbolRenderingMode(SymbolRenderingMode.palette)
                .foregroundStyle(.primary, backgroundIconColor)
                
            Text(title)
        }
    }
}
