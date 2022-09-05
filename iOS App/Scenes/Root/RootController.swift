import UIKit
import SparrowKit
import NativeUIKit
import SPDiffable
import SPSettingsIcons
import CameraPermission
import SPIndicator

class RootController: SPDiffableTableController {
    
    // MARK: - Views
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    let headerView = RootControllerHeaderView()
    open var headerContainerView: HeaderContainerView
    private var cachedHeaderHeight: CGFloat? = nil
    
    var passwordsData: [AccountModel] = []
    var filteredData: [AccountModel] = []
    
    // MARK: - Init
    
    public override init(style: UITableView.Style) {
        self.headerContainerView = HeaderContainerView(contentView: self.headerView)
        super.init(style: style)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(reload), userInfo: nil, repeats: true)
        passwordsData = AppSettings.getAllFromKeychain()
        diffableDataSource?.set(content, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        diffableDataSource?.set(content, animated: false)
    }
    
    // MARK: Layout
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.navigationBar.layoutMargins.left = view.layoutMargins.left
        self.navigationController?.navigationBar.layoutMargins.right = view.layoutMargins.left
        
        headerContainerView.contentView.layoutMargins.left = tableView.layoutMargins.left
        headerContainerView.contentView.layoutMargins.right = tableView.layoutMargins.right
        headerContainerView.setWidthAndFit(width: view.frame.width)
        if cachedHeaderHeight != headerContainerView.frame.height {
            cachedHeaderHeight = headerContainerView.frame.height
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.diffableDataSource?.updateLayout(animated: false, completion: nil)
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(
            alongsideTransition: { _ in
                self.navigationController?.navigationBar.layoutMargins.left = self.view.layoutMargins.left
                self.navigationController?.navigationBar.layoutMargins.right = self.view.layoutMargins.left
            },
            completion: nil
        )
    }
    
    open func setSpaceBetweenHeaderAndCells(_ value: CGFloat) {
        headerContainerView.layoutMargins.bottom = value
    }
    
    // MARK: - Diffable
    
    var content: [SPDiffableSection] {
        var sections: [SPDiffableSection] = []
        
        let accountsSection = SPDiffableSection(
            id: Section.accounts.id,
            header: SPDiffableTextHeaderFooter(text: Texts.RootController.account_section_header),
            footer: SPDiffableTextHeaderFooter(text: Texts.RootController.account_section_footer),
            items: []
        )
        
        if isFiltering {
            for model in filteredData {
                let item = SPDiffableWrapperItem(
                    id: "\(model.oneTimePassword)",
                    model: model) { item, indexPath in
                        let indicatorView = SPIndicatorView(title: Texts.Shared.copied, preset: .done)
                        indicatorView.present(duration: 3)
                        guard let cell = self.tableView.cellForRow(at: indexPath) as? OTPTableViewCell else { return }
                        cell.copyButton.isHighlighted = true
                        UIPasteboard.general.string = cell.password
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            cell.copyButton.isHighlighted = false
                        }
                    }
                accountsSection.items.append(item)
            }
        } else {
            for model in passwordsData {
                let item = SPDiffableWrapperItem(
                    id: "\(model.oneTimePassword)",
                    model: model) { item, indexPath in
                        AlertService.copied()
                        guard let cell = self.tableView.cellForRow(at: indexPath) as? OTPTableViewCell else { return }
                        cell.copyButton.isHighlighted = true
                        UIPasteboard.general.string = cell.password
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            cell.copyButton.isHighlighted = false
                        }
                    }
                accountsSection.items.append(item)
            }
        }
        
        if accountsSection.items.isEmpty {
            accountsSection.items.append(
                NativeEmptyRowItem.init(
                    id: "empty cell",
                    verticalMargins: .medium,
                    text: Texts.RootController.empty_cell_title,
                    detail: Texts.RootController.empty_cell_subitle)
            )
        }
        
        sections.append(accountsSection)
        
        let settingsSection = SPDiffableSection(
            id: Section.settings.id,
            header: nil,
            footer: SPDiffableTextHeaderFooter(text: Texts.RootController.settings_section_footer),
            items: [
                NativeDiffableLeftButton(
                    id: "settings button",
                    text: Texts.RootController.settings_button,
                    detail: nil,
                    icon: Images.settings,
                    accessoryType: .disclosureIndicator,
                    action: { item, indexPath in
                        let settingsVC = NativeNavigationController.init(rootViewController: SettingsController(style: .insetGrouped))
                        settingsVC.modalPresentationStyle = .fullScreen
                        self.present(settingsVC, animated: true, completion: nil)
                    }
                )
            ]
        )
        sections.append(settingsSection)
        
        return sections
    }
    
    enum Section: String {
        case accounts
        case settings
        
        var id: String { rawValue }
    }
}
