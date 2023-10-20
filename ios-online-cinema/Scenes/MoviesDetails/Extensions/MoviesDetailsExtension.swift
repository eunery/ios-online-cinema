//
//  MoviesDetailsExtension.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 20.10.2023.
//

import Foundation
import UIKit

extension MoviesDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.viewModel.dataSource[indexPath.row]
        switch item.type {
        case .poster:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviePosterTableViewCell.identifier,
                                                           for: indexPath) as? MoviePosterTableViewCell,
                  let item = item as? MoviesDetailsPosterCellData else { return UITableViewCell() }
            cell.configure(cellModel: item)
            
            return cell
        case .info:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieInfoTableViewCell.identifier,
                                                           for: indexPath) as? MovieInfoTableViewCell,
                  let item = item as? MoviesDetailsInfoCellData else { return UITableViewCell() }
            cell.configure(cellModel: item)
            cell.cellActions = self
            
            return cell
        case .overview:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieOverviewTableViewCell.identifier,
                                                           for: indexPath) as? MovieOverviewTableViewCell,
                  let item = item as? MoviesDetailsOverviewCellData else { return UITableViewCell() }
            cell.configure(cellModel: item)
            
            return cell
        }
    }
}

extension MoviesDetailsViewController: MovieInfoTableViewCellActions {
    func deleteFromFavourites() {
        self.viewModel.deleteFromFavoruites()
    }
    
    func addToFavourites() {
        do {
            try self.viewModel.addToFavourites()
        } catch let error as APIError {
            self.tableView.reloadData()
            showError(error: error)
        } catch { }
    }
}
