import UIKit

extension HomeController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(searchText: String) {
        let filteredDataFromWebsite = passwordsData.filter { model in
            return model.issuer.lowercased().contains(searchText.lowercased())
        }
        
        let filteredDataFromLogin: [AccountModel] = passwordsData.filter { model in
            return model.login.lowercased().contains(searchText.lowercased())
        }
        
        filteredData = filteredDataFromWebsite
        for item in filteredDataFromLogin {
            if !filteredData.contains(item) {
                filteredData.append(item)
            }
        }
        self.diffableDataSource?.set(self.content, animated: true)
    }
}
