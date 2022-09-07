import UIKit
import NativeUIKit
import PermissionsKit
import SPDiffable
import SPAlert
import OTP

extension RootController {
    
    // MARK: - Actions
    
    @objc func scanButtonTapped() {
        
        if Permission.camera.notDetermined {
            Permission.camera.request {
                if Permission.camera.authorized {
                    self.scaning()
                }
            }
        } else if Permission.camera.denied {
            let alertController = UIAlertController(
                title: Texts.Permissions.denied_title,
                message: Texts.Permissions.denied_subtitle,
                preferredStyle: .alert
            )
            
            let settingsAction = UIAlertAction(title: Texts.Permissions.denied_action, style: .default) { (_) -> Void in
                
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        
                    })
                }
            }
            alertController.addAction(settingsAction)
            let cancelAction = UIAlertAction(title: Texts.Shared.cancel, style: .default, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        } else {
            if Permission.camera.authorized {
                self.scaning()
            }
        }
        if Permission.camera.authorized {
            self.scaning()
        }
    }
    
    // MARK: - Methods
    
    // MARK: UI
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Texts.RootController.title
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    func setupTableView() {
        passwordsData = AppSettings.getAllFromKeychain()
        tableView.register(NativeEmptyTableViewCell.self)
        tableView.register(OTPTableViewCell.self)
        configureDiffable(sections: content, cellProviders: [.empty, .account] + SPDiffableTableDataSource.CellProvider.default)
        headerContainerView.setWidthAndFit(width: view.frame.width)
        tableView.tableHeaderView = headerContainerView
        diffableDataSource?.mediator = self
        diffableDataSource?.diffableDelegate = self
        headerView.scanButton.addTarget(self, action: #selector(scanButtonTapped), for: .primaryActionTriggered)
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
    }
    
    @objc func reload() {
        let time = Date().timeIntervalSince1970
        var partFrom30Seconds = Double(Int(time/30) + 1) - time/30
        partFrom30Seconds = Double(round(100 * partFrom30Seconds) / 100)
        let secondsBeforeUpdate = Int(partFrom30Seconds * 30)
        let barButtonItem = UIBarButtonItem(image: imageForNumber(number: secondsBeforeUpdate))
        if !passwordsData.isEmpty {
            self.navigationItem.rightBarButtonItem = barButtonItem
        } else {
            navigationItem.rightBarButtonItem = nil
        }
        if secondsBeforeUpdate == 0 || secondsBeforeUpdate == 30 {
            self.diffableDataSource?.set(self.content, animated: false)
        }
        
    }
    
    // MARK: 2FA
    
    private func imageForNumber(number: Int) -> UIImage {
        let image = UIImage.system("\(number).circle.fill", font: UIFont.systemFont(ofSize: 19, weight: .medium))
        return image
    }
    
    private func cutSymbols(model: QRCodeData) -> String {
        var string = "\(model)"
        for _ in 0...3 {
            string.remove(at: string.startIndex)
        }
        string.remove(at: string.index(before: string.endIndex))
        
        return string
    }
    
    private func cutStringToLoginAndWebsite(string: String) -> [String] {
        var cuttedString = string
        cuttedString.remove(at: cuttedString.startIndex)
        let array = cuttedString.components(separatedBy: ":")
        
        return array
    }
    
    private func scaning() {
        
        QRCode.scanning(
            detect: { data, controller in
                
                // When founded
                
                return data
            },
            handled: { [weak self] data, controller in
                
                // When clicked
                
            },
            on: self
        )
    }
    
    func handledQR(dataQR: QRCodeData) {
        let tranformedData = self.cutSymbols(model: dataQR)
        guard let url = URL(string: tranformedData) else {
            AlertService.alertIncorrectURL(controller: self)
            return
        }
        
        let name = url.lastPathComponent
        let issuer = url.valueOf("issuer")
        let secret = url.valueOf("secret")
        
        guard let components = URLComponents(string: tranformedData) else {
            AlertService.alertNoToken(controller: self)
            return
        }
        guard components.scheme != nil else {
            AlertService.alertNoToken(controller: self)
            return
        }
        guard "\(components)".contains("secret") else {
            AlertService.alertNoToken(controller: self)
            return
        }
        guard "\(components)".contains("totp") else {
            AlertService.alertNoToken(controller: self)
            return
        }
        
        if secret == nil {
            AlertService.alertIncorrectURL(controller: self)
            return
        }
        if tranformedData == .empty {
            AlertService.alertIncorrectURL(controller: self)
            return
        }
        if issuer == nil {
            AlertService.alertIncorrectURL(controller: self)
            return
        }
        if name.isEmpty {
            AlertService.alertIncorrectURL(controller: self)
            return
        }
        
        guard let url = URL(string: tranformedData) else {
            AlertService.alertIncorrectURL(controller: self)
            return
        }
        guard let token = url.valueOf("secret") else {
            AlertService.alertNoToken(controller: self)
            return
        }
        guard let secret = base32DecodeToData(token) else {
            AlertService.alertNoToken(controller: self)
            return
        }
        guard let checkCode = OTP.generateOTP(secret: secret) else {
            AlertService.alertNoToken(controller: self)
            return
        }
        if checkCode.isEmpty {
            AlertService.alertNoToken(controller: self)
            return
        }
        
        if issuer != nil && !name.isEmpty && !checkCode.isEmpty {
            let model = AccountModel(oneTimePassword: tranformedData, website: issuer!, login: name)
            if !self.passwordsData.contains(model) {
                AppSettings.saveToKeychain(id: tranformedData)
                self.passwordsData = AppSettings.getAllFromKeychain()
                AlertService.code_added()
                self.diffableDataSource?.set(self.content, animated: true)
                self.dismiss(animated: true)
            } else {
                AlertService.alertTheSameCode(controller: self)
            }
        } else {
            AlertService.alertIncorrectURL(controller: self)
        }
    }
    
}
