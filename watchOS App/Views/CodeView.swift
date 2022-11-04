import SwiftUI

struct CodeView: View {
    
    let account: AccountModel
    
    @Binding var fromDate: Date
    @State var progressColor: Color
    
    @AppStorage(Constants.ud_progress_show_key) var enabledProgress = true
    @AppStorage(Constants.ud_progress_show_profile) var enabledProfile = false
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    init(account: AccountModel, fromDate: Binding<Date>) {
        self.account = account
        _fromDate = fromDate
        _progressColor = State(initialValue: CodeView.getProgressColor(fromDate: fromDate.wrappedValue))
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 2) {
                    let prefix = account.oneTimePassword.prefix(3)
                    ForEach(prefix.map { String($0) }, id: \.self) { value in
                        NumberView(number: value)
                    }
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 2)
                    let suffix = account.oneTimePassword.suffix(3)
                    ForEach(suffix.map { String($0) }, id: \.self) { value in
                        NumberView(number: value)
                    }
                }
                .font(.title3)
                .fontWeight(.semibold)
                .fontDesign(.monospaced)
                VStack(alignment: .leading, spacing: 0) {
                    Text(account.website)
                        .foregroundColor(.secondary)
                        .font(.footnote)
                    if enabledProfile {
                        Text(account.login)
                            .foregroundColor(.secondary)
                            .font(.footnote)
                    }
                }
            }
            if enabledProgress {
                Spacer()
                VStack(alignment: .trailing) {
                    ProgressView(timerInterval: fromDate...fromDate.addingTimeInterval(30))
                        .progressViewStyle(.circular)
                        .font(.footnote)
                        .foregroundColor(.primary)
                        .tint(progressColor)
                }
            }
        }
        .padding(.vertical)
        .onReceive(timer) { input in
            self.progressColor = CodeView.getProgressColor(fromDate: self.fromDate)
        }
    }
    
    static func getProgressColor(fromDate: Date) -> Color {
        return ((fromDate.addingTimeInterval(30).timeIntervalSince1970 - Date().timeIntervalSince1970) <= 5) ? .red : .accentColor
    }
}


struct CodeView_Previews: PreviewProvider {
    
    static var previews: some View {
        CodeView(
            account: .init(
                oneTimePassword: "JBSWY3DPEHPK3XRD",
                website: "fdsfsfds fdsfsfds fdsfsfds fdsfsfds fdsfsfds fdsfsfds fdsfsfds",
                login: "fdsfsfds fdsfsfds fdsfsfds fdsfsfds fdsfsfds fdsfsfds fdsfsfds"),
            fromDate: .constant(Date())
        )
    }
}
