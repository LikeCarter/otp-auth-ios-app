import UIKit
import SparrowKit
import NativeUIKit
import SPDiffable
import SPSettingsIcons

class SettingsPasswordController: SPDiffableTableController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = Texts.SettingsController.title
        configureDiffable(sections: content, cellProviders: SPDiffableTableDataSource.CellProvider.default)
        tableView.cellLayoutMarginsFollowReadableWidth = true
    }
    
    // MARK: - Diffable
    
    var content: [SPDiffableSection] {
        var sections: [SPDiffableSection] = []
 
        let appSection = SPDiffableSection(
            id: Section.password.id,
            header: SPDiffableTextHeaderFooter(text: Texts.SettingsController.app_section_header),
            footer: SPDiffableTextHeaderFooter(text: Texts.SettingsController.app_section_footer),
            items: [
                SPDiffableTableRowSwitch(
                    id: "password",
                    text: Texts.SettingsController.Password.cell,
                    icon: nil,
                    isOn: AppSettings.isPasswordEnabled,
                    action: { state in
                        AppSettings.isPasswordEnabled = state
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
