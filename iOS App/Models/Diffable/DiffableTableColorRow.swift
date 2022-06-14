import UIKit
import SparrowKit
import NativeUIKit
import SPDiffable

class DiffableTableColorRow: SPDiffableActionableItem {
    
    var text: String
    var detail: String? = nil
    var icon: UIImage? = nil
    var selectionStyle: UITableViewCell.SelectionStyle
    var accessoryType: UITableViewCell.AccessoryType
    
    init(id: String? = nil, text: String, detail: String? = nil, icon: UIImage? = nil, accessoryType: UITableViewCell.AccessoryType = .none, selectionStyle: UITableViewCell.SelectionStyle = .none, action: Action? = nil) {
        self.text = text
        self.detail = detail
        self.icon = icon
        self.accessoryType = accessoryType
        self.selectionStyle = selectionStyle
        super.init(id: id ?? text, action: action)
    }
}
