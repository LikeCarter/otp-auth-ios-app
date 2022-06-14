import UIKit
import SparrowKit
import NativeUIKit
import SPDiffable
import SPSettingsIcons

class SettingsAboutAppController: SPDiffableTableController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = Texts.SettingsController.AboutApp.title
        configureDiffable(sections: content, cellProviders: SPDiffableTableDataSource.CellProvider.default)
        tableView.cellLayoutMarginsFollowReadableWidth = true
    }
    
    // MARK: - Diffable
    
    var content: [SPDiffableSection] {
        var sections: [SPDiffableSection] = []
 
        let versionSection = SPDiffableSection(
            id: Section.version.id,
            header: SPDiffableTextHeaderFooter(text: Texts.SettingsController.AboutApp.version_header),
            footer: SPDiffableTextHeaderFooter(text: Texts.SettingsController.AboutApp.version_footer),
            items: [
                SPDiffableTableRow(
                    id: "Version",
                    text: Texts.SettingsController.AboutApp.version_cell_title,
                    detail: Texts.SettingsController.AboutApp.version_cell_detail,
                    icon: nil,
                    accessoryType: .none,
                    selectionStyle: .none,
                    action: nil
                )
            ]
        )
        sections.append(versionSection)
        
        /*
        let packagesSection = SPDiffableSection(
            id: Section.package.id,
            header: SPDiffableTextHeaderFooter(text: Texts.SettingsController.app_section_header),
            footer: SPDiffableTextHeaderFooter(text: Texts.SettingsController.app_section_footer),
            items: [
                SPDiffableTableRow(
                    id: "Version",
                    text: Texts.SettingsController.AboutApp.version_cell_title,
                    detail: Texts.SettingsController.AboutApp.version_cell_detail,
                    icon: nil,
                    accessoryType: .none,
                    selectionStyle: .none,
                    action: nil
                )
            ]
        )
        */
        
        return sections
    }
    
    enum Section: String {
        case version
        case package
        
        var id: String { rawValue }
    }
    
}
