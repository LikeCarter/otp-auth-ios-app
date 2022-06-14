import UIKit
import SparrowKit
import NativeUIKit
import SPDiffable

class SettingsLanguagesController: SPDiffableTableController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = Texts.SettingsController.Languages.title
        tableView.showsHorizontalScrollIndicator = false
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
        configureDiffable(sections: content, cellProviders: SPDiffableTableDataSource.CellProvider.default)
    }
    
    // MARK: - Diffable
    
    var content: [SPDiffableSection] {
        let languagesSection = SPDiffableSection.init(
            id: Section.languages.id,
            header: SPDiffableTextHeaderFooter.init(
                text: Texts.SettingsController.Languages.header
            ),
            footer: SPDiffableTextHeaderFooter.init(
                text: Texts.SettingsController.Languages.footer
            ),
            items: AppLanguage.allCases.map({ language in
                return SPDiffableTableRowSubtitle.init(
                    text: language.titleText,
                    subtitle: language.detailText,
                    icon: nil,
                    accessoryType: AppLanguage.state() == language ? .checkmark : .none,
                    selectionStyle: .none,
                    action: { item, indexPath in
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }
                )
            })
        )
        
        return [languagesSection]
        
    }
    
    enum Section: String {
        case languages
        
        var id: String { return self.rawValue }
        var header: String { id + "_header" }
        var footer: String { id + "_footer" }
    }
    
    enum Item: String {
        case russian
        case english
        
        var id: String { rawValue }
    }
    
}
