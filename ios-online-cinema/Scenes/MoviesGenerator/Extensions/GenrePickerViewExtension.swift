//
//  GenrePickerViewExtension.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 20.10.2023.
//

import Foundation
import UIKit

extension GenrePickerViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.filteredGenresNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
        let item = self.viewModel.filteredGenresNames[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: GenrePickerTableViewCell.identifier,
            for: indexPath) as? GenrePickerTableViewCell else { return UITableViewCell() }
        cell.genreName.text = item.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.viewModel.filteredGenresNames[indexPath.row]
        self.delegate?.selectData(text: item)
        self.dismiss(animated: true)
    }
}

extension GenrePickerViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.filterGenres(searchText: searchText)

        tableView.reloadData()
    }
}
