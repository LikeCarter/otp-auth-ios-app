import UIKit
import SparrowKit
import NativeUIKit
import SPDiffable
import SPSettingsIcons
import PermissionsKit
import FaceIDPermission

class SettingsPasswordController: SPDiffableTableController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = Texts.SettingsController.Password.title
        configureDiffable(sections: content, cellProviders: SPDiffableTableDataSource.CellProvider.default)
        tableView.cellLayoutMarginsFollowReadableWidth = true
    }
    
    // MARK: - Diffable
    
    var content: [SPDiffableSection] {
        var sections: [SPDiffableSection] = []
        
        let appSection = SPDiffableSection(
            id: Section.password.id,
            header: SPDiffableTextHeaderFooter(text: Texts.SettingsController.Password.header),
            footer: SPDiffableTextHeaderFooter(text: Texts.SettingsController.Password.footer),
            items: [
                SPDiffableTableRowSwitch(
                    id: "password",
                    text: Texts.SettingsController.Password.cell,
                    icon: nil,
                    isOn: AppSettings.isPasswordEnabled,
                    action: { currentState in
                        AppLocalAuthentication.request(reason: Texts.Auth.change_description) { (state) in
                            if state {
                                AppSettings.isPasswordEnabled = currentState
                                self.diffableDataSource?.set(self.content, animated: true)
                            } else {
                                self.diffableDataSource?.set(self.content, animated: true)
                            }
                            
                        }
                    }
                )
            ]
        )
        sections.append(appSection)
        
        return sections
    }
    
    enum Section: String {
        case password
        
        var id: String { rawValue }
    }
    
}
