import UIKit
import SparrowKit
import NativeUIKit
import SPDiffable
import SPSettingsIcons
import CameraPermission
import SPIndicator

class HomeController: SPDiffableTableController {
    
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
    var scannedData: [String] = []
    
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
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Texts.HomeController.title
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
        passwordsData = AppSettings.getAllFromKeychain()
        
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.register(NativeEmptyTableViewCell.self)
        tableView.register(OTPTableViewCell.self)
        configureDiffable(sections: content, cellProviders: [.empty, .account] + SPDiffableTableDataSource.CellProvider.default)
        headerContainerView.setWidthAndFit(width: view.frame.width)
        tableView.tableHeaderView = headerContainerView
        diffableDataSource?.mediator = self
        diffableDataSource?.diffableDelegate = self
        
        headerView.scanButton.addTarget(self, action: #selector(scanButtonTapped), for: .primaryActionTriggered)
        
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(reload), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let gradeView = UIView()
        gradeView.backgroundColor = .systemBackground
        view.addSubview(gradeView)
        gradeView.frame = view.bounds
        UIView.animate(withDuration: 0.22, animations: {
            gradeView.alpha = 0
        }, completion: { finished in
            gradeView.removeFromSuperview()
        })
        print("call here 2 \(Int.random(in: 1...100))")
        diffableDataSource?.set(content, animated: false)
    }
    
    // MARK: Layout
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.navigationBar.layoutMargins.left = view.layoutMargins.left
        self.navigationController?.navigationBar.layoutMargins.right = view.layoutMargins.left
        
        var layoutContainer = false
        if headerContainerView.contentView.layoutMargins.left != tableView.layoutMargins.left {
            headerContainerView.contentView.layoutMargins.left = tableView.layoutMargins.left
            layoutContainer = true
        }
        if headerContainerView.contentView.layoutMargins.right != tableView.layoutMargins.right {
            headerContainerView.contentView.layoutMargins.right = tableView.layoutMargins.right
            layoutContainer = true
        }
        if layoutContainer || headerContainerView.frame.width != view.frame.width {
            headerContainerView.setWidthAndFit(width: view.frame.width)
        }
        
        if cachedHeaderHeight != headerContainerView.frame.height {
            cachedHeaderHeight = headerContainerView.frame.height
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                print("call here 3 \(Int.random(in: 1...100))")
                self.diffableDataSource?.updateLayout(animated: false, completion: nil)
            }
        }
    }
    
    // MARK: - Diffable
    
    var content: [SPDiffableSection] {
        print("call here 4 \(Int.random(in: 1...100))")
        var sections: [SPDiffableSection] = []
        
        let accountsSection = SPDiffableSection(
            id: Section.accounts.id,
            header: SPDiffableTextHeaderFooter(text: Texts.HomeController.account_section_header),
            footer: SPDiffableTextHeaderFooter(text: Texts.HomeController.account_section_footer),
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
                    text: Texts.HomeController.empty_cell_title,
                    detail: Texts.HomeController.empty_cell_subitle)
            )
        }
        
        sections.append(accountsSection)
        
        let settingsSection = SPDiffableSection(
            id: Section.settings.id,
            header: nil,
            footer: SPDiffableTextHeaderFooter(text: Texts.HomeController.settings_section_footer),
            items: [
                NativeDiffableLeftButton(
                    id: "settings button",
                    text: Texts.HomeController.settings_button,
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
