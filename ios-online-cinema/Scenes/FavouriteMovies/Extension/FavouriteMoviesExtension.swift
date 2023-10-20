//
//  FavouriteMoviesExtension.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 20.10.2023.
//

import Foundation
import UIKit

extension FavouriteMoviesViewController: UITableViewDelegate,
                                         UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FavouriteMovieTableViewCell.identifier,
            for: indexPath) as? FavouriteMovieTableViewCell else { return UITableViewCell() }
        cell.configure(cellModel: self.viewModel.dataSource[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FavouriteMovieTableViewCell {
            guard let id = cell.id else { return }
            self.coordinator?.showMoviesDetails(movieId: id)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let cell = tableView.cellForRow(at: indexPath) as? FavouriteMovieTableViewCell,
                  let id = cell.id else { return }
            self.viewModel.deleteMovie(id: id)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
