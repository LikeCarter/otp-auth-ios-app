import UIKit
import SparrowKit
import NativeUIKit
import SPDiffable

class SettingsAppearanceController: SPDiffableTableController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = Texts.SettingsController.Appearance.title
        tableView.showsHorizontalScrollIndicator = false
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
        tableView.register(ColorTableViewCell.self)

        configureDiffable(
            sections: content,
            cellProviders: [.color] + SPDiffableTableDataSource.CellProvider.default,
            headerFooterProviders: []
        )
    }
    
    // MARK: - Actions
    
    func setColor(color: AppColor) {
        AppTintColorService.set(color: color)
        UIFeedbackGenerator.impactOccurred(.selectionChanged)
        
        self.diffableDataSource?.set(self.content, animated: true)
    }
    
    func setStyle(style: AppTheme) {
        AppThemeService.set(style: style)
        self.diffableDataSource?.set(self.content, animated: true)
    }
    
    // MARK: - Diffable
    
    var content: [SPDiffableSection] {
        let colorsSection = SPDiffableSection(
            id: Section.colors.id,
            header: SPDiffableTextHeaderFooter(
                text: Texts.SettingsController.Appearance.colors_header
            ),
            footer: SPDiffableTextHeaderFooter(
                text: Texts.SettingsController.Appearance.colors_footer
            ),
            items: AppColor.allCases.map({ color in
                return DiffableTableColorRow(
                    id: color.id,
                    text: color.title,
                    detail: nil,
                    icon: color.image,
                    accessoryType: Settings.appColor == color ? .checkmark : .none,
                    selectionStyle: .none,
                    action: { item, indexPath in
                        self.setColor(color: color)
                    }
                )
            })
        )
        
        let automaticSection = SPDiffableSection(
            id: Section.automatic.id,
            header: SPDiffableTextHeaderFooter.init(
                text: Texts.SettingsController.Appearance.appearance_header
            ),
            footer: SPDiffableTextHeaderFooter.init(
                text: Texts.SettingsController.Appearance.automatic_footer
            ),
            items: [
                SPDiffableTableRowSwitch(
                    id: Item.automatic.id,
                    text: Texts.SettingsController.Appearance.automatic_cell,
                    icon: nil,
                    isOn: Settings.isAppearanceAutomatic,
                    action: { state in
                        Settings.isAppearanceAutomatic = state
                        if Settings.isAppearanceAutomatic {
                            self.setStyle(style: .automatic)
                        } else {
                            self.setStyle(style: .light)
                        }
                    }
                )
            ]
        )
        let manuallySection = SPDiffableSection(
            id: Section.manually.id,
            header: nil,
            footer: SPDiffableTextHeaderFooter(
                text: Texts.SettingsController.Appearance.manually_footer
            ),
            items: [
                SPDiffableTableRow.init(
                    id: Item.light.id,
                    text: Texts.SettingsController.Appearance.light_cell,
                    detail: nil,
                    icon: nil,
                    accessoryType: Settings.appTheme == .light ? .checkmark : .none,
                    selectionStyle: .none,
                    action: { item, indexPath in
                        self.setStyle(style: .light)
                    }
                ),
                SPDiffableTableRow.init(
                    id: Item.dark.id,
                    text: Texts.SettingsController.Appearance.dark_cell,
                    detail: nil,
                    icon: nil,
                    accessoryType: Settings.appTheme == .dark ? .checkmark : .none,
                    selectionStyle: .none,
                    action: { item, indexPath in
                        self.setStyle(style: .dark)
                    }
                )
            ]
        )
        
        if Settings.isAppearanceAutomatic {
            return [automaticSection, colorsSection]
        } else {
            return [automaticSection, manuallySection, colorsSection]
        }
        
    }
    
    enum Section: String {
        case colors
        case automatic
        case manually
        
        var id: String { return self.rawValue }
        var header: String { id + "_header" }
        var footer: String { id + "_footer" }
    }
    
    enum Item: String {
        case automatic
        case light
        case dark
        
        var id: String { rawValue }
    }
    
}
