import SwiftUI

struct Code: Identifiable {
    
    var id: String { self.code }
    let code: String
    
    init(code: String) {
        self.code = code
    }
}
