import UIKit
import SPDiffable
import SPAlert

extension HomeController: SPDiffableTableDelegate, SPDiffableTableMediator {
    
    func diffableTableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func diffableTableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForItem item: SPDiffableItem, at indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let modelID = item.id
        var actions = UISwipeActionsConfiguration(actions: [])
        if indexPath.section == 0 {
            if !passwordsData.isEmpty {
                let actionDelete = UIContextualAction(style: .destructive, title: Texts.Shared.delete) { [weak self] action, view, completion in
                    guard let self = self else { return }
                    
                    let alert = UIAlertController(
                        title: Texts.RootController.delete_alert_title,
                        message: Texts.RootController.delete_alert_message,
                        preferredStyle: .actionSheet
                    )
                    let delete = UIAlertAction(
                        title: Texts.Shared.delete,
                        style: .destructive) { alert in
                            self.passwordsData.remove(at: indexPath.row)
                            AppSettings.removeFromKeychain(id: modelID)
                            self.diffableDataSource?.set(self.content, animated: true)
                            AlertService.code_deleted()
                        }
                    let cancel = UIAlertAction(
                        title: Texts.Shared.cancel,
                        style: .default,
                        handler: nil
                    )
                    alert.addAction(delete)
                    alert.addAction(cancel)
                    self.present(alert, animated: true, completion: nil)
                    
                }
                let actionDel = UISwipeActionsConfiguration(actions: [actionDelete])
                actions = actionDel
            }
        }
        return actions
    }
}
